From: "Piotr A." =?iso-8859-2?Q?Fr=B1tczak?= <paf@toya.net.pl>
Subject: Re: Request for help with snd-hda-intel ICH6 CMI9880
Date: Fri, 10 Feb 2006 16:26:17 +0100
Message-ID: <1139585177.9775.1.camel@localhost>
References: <1138910835.9837.8.camel@localhost>
	 <1138912806.15691.106.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1138912806.15691.106.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dnia 02-02-2006, czw o godzinie 15:40 -0500, Lee Revell napisa=B3(a):
> Try all the different "model=3D" options for hda-intel described in
> ALSA-Configuration.txt and report back here if any of them help.

I should have mentioned that previously, but I did try all the possible
model=3D previously and even the ones not fot this chip. Nothing changes.
What I did obtain by checking all the possible mixer setting is that I
am able to record the sound (in my case it's the TV card's sound) using
the gnome-mixer(?). I have to:
1) change to "1: C-MEDIA CMI9880 (OSS MIXER)
2) set the In-Gain to 100
3) go back to "0: HDA Intel (ALSA MIXER)
4) in 'option tab' set the input0 source to 'rear mic'
5) in the 'recording tab' set the capture0: the 'speaker icon' unmute,
and mute the 'mic icon'(capture switch?) - if I want mic then this
switch should be unmuted. The input source is connected to the
motherboard cd-in.=20
That way I am able to record the sound with the gnome's recording, but I
don't hear it until I play the recorded part. AFAIK it's 'model=3D'
independent, but didn't check it - the current is:

$ grep model /etc/modprobe.conf
options snd-hda-intel index=3D0 model=3Dmin_fp position_fix=3D3

I know that my description is quite unprofessional - please forgive me
and guide me how to list these settings for you.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
