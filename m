From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fwd: [Alsa-user] Recording spdif/iec958 on	ice1724
	terratec aureon 7.1 space
Date: Mon, 19 Jun 2006 19:55:25 -0400
Message-ID: <1150761326.2754.75.camel@mindpipe>
References: <124299980606190740v47ab8c9dgedbb88a9f607a572@mail.gmail.com>
	<s5hwtbdi02g.wl%tiwai@suse.de>  <4497355D.80704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4497355D.80704@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ian Malone <ibmalone@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-20 at 00:38 +0100, Ian Malone wrote:

> Well, this is /etc/asound.state, whether it corresponds to what
> I'm actually using I don't know.
> 

Run "alsactl store" to verify that asound.state matches the mixer
settings.

> Optical is selected for the IEC958 capture source, I also tried
> CD just to see if it made a difference.
> 
> Thanks for your time.

> 	control.51 {
> 		comment.access 'read write'
> 		comment.type BOOLEAN
> 		comment.count 1
> 		iface MIXER
> 		name 'IEC958 Capture Switch'
> 		value false
> 	}

Have you tried unmuting "IEC958 Capture Switch"?

Lee
