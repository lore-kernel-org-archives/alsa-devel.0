From: Henry Walpool <apkennedy@firstlinux.net>
Subject: Fwd: Re: DSP24 MEDIA 7.1 - Linux/Alsa support?
Date: Wed, 27 Nov 2002 06:47:40 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021127144740.2E3D942F9@sitemail.everyone.net>
Reply-To: apkennedy@firstlinux.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1038408460-27306-1"
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: claus@staudio.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1038408460-27306-1
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi

Please review the attached message. I was requested to post this message in the alsa-devel group by the author. I would like to get my hoontech/staudio 7.1 sound system working with linux and I'm very close. I still can't control the volume, and I made the changes in the source code recommend by the author. 

Another small problem that I'm working is envy24control only shows s/pdif in the patchbay/router, and think it should show more than that. Is this true?

Also with envy24control I got the following error messages:Unable to read S/PDIF master state: No such file or directory
Unable to read Delta S/PDIF output state: No such file or directory
Unable to write Delta S/PDIF Output Defaults: No such file or directory

I looked at the code and their is no hoontech/staudio support in this section. Does anyone have information on the correct hooks to set the spdif state for hoontech dsp24.

Sorry for the long post, but I'm more than willing to learn and try to get this working. I can record/playback but can't get the mixer to work yet. 

Thanks Claus for getting me started in the right direction. 

Thanks,

Alan



*** There is an attachment in this mail. ***

_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Select your own custom email address for FREE! Get you@yourchoice.com w/No Ads, 6MB, POP & more! http://www.everyone.net/selectmail?campaign=tag

------------=_1038408460-27306-1
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: binary

Received: from www.staudio.com (unknown [203.248.187.2])
	by imta04.mta.everyone.net (Postfix) with ESMTP id DE8B618FAFA
	for <apkennedy@firstlinux.net>; Tue, 26 Nov 2002 21:10:04 -0800 (PST)
Received: (from nobody@localhost)
	by www.staudio.com (8.9.3/8.9.3) id NAA03672;
	Wed, 27 Nov 2002 13:56:30 +0900
Date: Wed, 27 Nov 2002 13:56:30 +0900
Message-Id: <200211270456.NAA03672@www.staudio.com>
Subject: Re: DSP24 MEDIA 7.1 - Linux/Alsa support?
From: "CWB-Mailer (STA1:17944)" <forum@staudio.de>
Reply-To: "Claus R" <claus@staudio.de>
To: apkennedy@firstlinux.net
Organization: Nobreak Technologies, Inc.
X-Mailer: CrazyWWWBoard 98 Professional Edition II (UNIX)
Sender: nobody@www.staudio.com


-- [ Article Information ] -----------------------------------------------
 Name.....: Claus R (mailto:claus@staudio.de)
 Subject..: Re: DSP24 MEDIA 7.1 - Linux/Alsa support?
 View.....: http://www.hoontech.com/board/cgi-bin/CrazyWWWBoard.cgi?db=STA1&mode=read&num=17944
 Reply....: http://www.hoontech.com/board/cgi-bin/CrazyWWWBoard.cgi?db=STA1&mode=reply&num=17944
-- [ Contents ] ----------------------------------------------------------
Hi,

> 1) Don't you mean "comment" instead of "uncomment"? Please look at your 
> first response. 

Of course. No GPIO calls need to be made.

> 2) Is this the correct function -> snd_ice1712_stdsp24_box_channel. I 
> found the "/* select box */" section in two different functions. The 
> other function was for the midi. I assume that channel function is the 
> correct one. 

Also the GPIO calls for MIDI are not needed.

> I have posted in the alsa-developer list.

Once one of the developers sees the message, I can reply there with more detailed information. I am monitoring the ALSA developer list (not the ALSA user list).

Best regards,

Claus
---[ End ] ---------------------------------------------------------------

------------=_1038408460-27306-1--


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
