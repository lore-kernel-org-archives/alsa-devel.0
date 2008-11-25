From: nescivi <nescivi@gmail.com>
Subject: problem with scheduling alsa events
Date: Tue, 25 Nov 2008 10:09:58 -0500
Message-ID: <200811251009.58254.nescivi@gmail.com>
Reply-To: nescivi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa0.perex.cz (Postfix) with ESMTP id EF33424471
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:10:07 +0100 (CET)
Content-disposition: inline
Received: from pantometheus.local ([24.37.46.220])
	by VL-MO-MR005.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007;
	32bit))
	with ESMTP id <0KAW003WPA3GZB20@VL-MO-MR005.ip.videotron.ca> for
	alsa-devel@alsa-project.org; Tue, 25 Nov 2008 10:09:16 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hiho,

In the Midi output code of this opensource project I am working on, there i=
s a =

problem with the timing when alsa events are scheduled in the future.
The events take much longer to arrive (sometimes almost minutes later!).

Below is the code snippet.

Can anyone see what is wrong in here?
Let me know if you need more code...

This is with libasound2 1.0.16-2 (Debian unstable).

sincerely,
Marije


int SC_AlsaMidiClient::sendEvent(int outputIndex, int uid, snd_seq_event_t* =

evt, float late)
{
=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_real_time time;
=A0=A0=A0=A0=A0=A0=A0=A0
=A0=A0=A0=A0=A0=A0=A0=A0if ((outputIndex < 0) || (outputIndex >=3D mNumOutP=
orts)) return =

errIndexOutOfRange;

=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_ev_set_source(evt, mOutPorts[outputIndex]);
=A0=A0=A0=A0=A0=A0=A0=A0if (uid =3D=3D 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0// send to all subscribed p=
orts
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_ev_set_subs(evt);
=A0=A0=A0=A0=A0=A0=A0=A0} else {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0// send to specific port
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int cid, pid;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SC_AlsaParseUID(uid, cid, p=
id);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_ev_set_dest(evt, ci=
d, pid);
=A0=A0=A0=A0=A0=A0=A0=A0}

// late is the latency value in seconds in floats
=A0=A0=A0=A0=A0=A0=A0=A0if (late > 0.f) {
// old time calculation:
// =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time.tv_sec =3D (unsigned)(late *=
 1.0e-6f);
// =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time.tv_nsec =3D (unsigned)(late =
* 1.0e3f);
// new time calculation. The old one was not correct
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time.tv_sec =3D (unsigned)(=
late); // seconds
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time.tv_nsec =3D (unsigned)=
(late * 1.0e9f) % 1000000000; // =

nanoseconds
// should these be (long) instead???
=A0=A0=A0=A0=A0=A0=A0=A0} else {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0time.tv_sec =3D time.tv_nse=
c =3D 0;
=A0=A0=A0=A0=A0=A0=A0=A0}

=A0=A0=A0=A0=A0=A0=A0=A0post("MIDI (ALSA): sending event, time %i, %i, late=
 %f\n", =

time.tv_sec, =

time.tv_nsec, late);

=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_ev_schedule_real(evt, mQueue, 1, &time);
=A0=A0=A0=A0=A0=A0=A0=A0snd_seq_event_output_direct(mHandle, evt);

=A0=A0=A0=A0=A0=A0=A0=A0return errNone;
}
