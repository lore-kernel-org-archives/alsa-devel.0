From: reetesh chandran <reeteshchandran@yahoo.com>
Subject: Re: SALSA library and recording
Date: Wed, 15 Apr 2009 11:40:51 -0700 (PDT)
Message-ID: <185775.25127.qm@web30001.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web30001.mail.mud.yahoo.com (web30001.mail.mud.yahoo.com
	[209.191.69.18]) by alsa0.perex.cz (Postfix) with SMTP id 0089E1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 20:40:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Manisha Sankpal <manisha.sankpal@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Manisha,
=A0
Sorry this is not a response which will help you.
=A0
I am facing similar issue. I am using SALSA and I am trying to record from =
a USB headset. The USB headset does have a mixer elem "Mic". But when I use=
 snd_mixer_selem_get_capture_dB_range() or snd_mixer_selem_get_capture_volu=
me_range() I just get zeroes. =

=A0
I did not do any set() functions like snd_mixer_selem_set_capture_switch_al=
l(). Do I need to do that ? What is your source of info about how to set up=
 the mixer for capture ? =

=A0
Thanks in advance
Reetesh

--- On Wed, 4/15/09, Manisha Sankpal <manisha.sankpal@gmail.com> wrote:


From: Manisha Sankpal <manisha.sankpal@gmail.com>
Subject: [alsa-devel] SALSA library and recording
To: alsa-devel@alsa-project.org
Date: Wednesday, April 15, 2009, 9:32 AM


Hi All,
I am using salsa library to capture the data from the sound card.=A0 The
requirement is that the recording should be done from line-in port of the
sound card. The selection of "Line-in" port should be done=A0 programatical=
ly.


With ALSA library, I am able to select the line-in by calling
snd_mixer_selem_set_capture_switch_all()=A0 function. However, this function
is returning an error when SALSA library is used.=A0 Is there any other
function/way to select the line-in mixer element in the SALSA API?

The help would be appreciated.
Thanks & regards,
manisha
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



      =
