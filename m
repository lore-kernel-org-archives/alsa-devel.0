From: Federico Grau <grauf@rfa.org>
Subject: Re: Sound
Date: Thu, 8 Feb 2007 21:26:46 -0500
Message-ID: <20070209022646.GA25235@rfa.org>
References: <c99d7187abfe513910c0ca9886ffff21@optonline.net>
	<20070208223023.GA18278@rfa.org>
	<f0f1a399e9c96656d456f7d105cea380@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <f0f1a399e9c96656d456f7d105cea380@optonline.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Dey <jsdey@optonline.net>
Cc: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


chmod 660 /dev/snd/*

When you did a "chgrp audio /dev/snd/*", that corrected the group membership
issue with the users.  However, if you see the permission bits:
    crw------- 1 root root 116,  0 Feb  8 11:21 controlC0
    user  group  other
    rw-   ---    ---
Only the user has read and write permissions.  The chmod (change mode) command
up top should correct that and give you something like
    crw-rw---- 1 root root 116,  0 Feb  8 11:21 controlC0
    user  group  other
    rw-   rw-    ---

"man 1 chmod" for more details.

best to you,
donfede


On Thu, Feb 08, 2007 at 08:29:40PM -0500, John Dey wrote:
> Hi Frederico,
> 
> Thanks for your response.  I get the following:
> 
> [robo9@robo9 dev]$ ls -l /dev/snd
> total 0
> crw------- 1 root root 116,  0 Feb  8 11:21 controlC0
> crw------- 1 root root 116, 16 Feb  8 11:21 pcmC0D0p
> crw------- 1 root root 116,  1 Feb  8 11:21 seq
> crw------- 1 root root 116, 33 Feb  8 11:21 timer
> 
> which confirms my suspicion.  I changed group to audio and added user  
> to that group.  I changed permission.  But still no luck.  I get the  
> following from aplay:
> 
> [robo9@robo9 Desktop]$ aplay BWV535.wav
> ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> ALSA lib conf.c:3492:(_snd_config_evaluate) function  
> snd_func_card_driver returned error: No such device
> ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
> ALSA lib conf.c:3492:(_snd_config_evaluate) function snd_func_concat  
> returned error: No such device
> ALSA lib confmisc.c:1072:(snd_func_refer) error evaluating name
> ALSA lib conf.c:3492:(_snd_config_evaluate) function snd_func_refer  
> returned error: No such device
> ALSA lib conf.c:3961:(snd_config_expand) Evaluate error: No such device
> ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default
> aplay: main:547: audio open error: No such device
> 
> Any further suggestions would be appreciated.  Thanks.
> 
> John
> 
> John
> On Feb 8, 2007, at 5:30 PM, Federico Grau wrote:
> 
> >*** off list
> >
> >Hello John,
> >
> >Check the required permissions with this command:
> >    ls -la /dev/snd
> >
> >On my system I have device file permissions such as:
> >    crw-rw----   1 root audio 116,  24 Sep  9  2005 pcmC0D0c
> >
> >Which means my non-root users need to be in the "audio" group in order  
> >to use
> >the audio devices.
> >
> >donfede
> >
> >
> >On Thu, Feb 08, 2007 at 03:24:40PM -0500, John Dey wrote:
> >>Hello Members,
> >>
> >>I have posted here on the same topic but haven't received any
> >>responses.  I do have some new information that makes me believe that
> >>alsa is working just fine on my PS3 using YDL 5 but needs some
> >>adjustments to permissions on file/sockets.  aplay and speaker-test
> >>works as root but not as user.  What changes do I need to make so that
> >>I can run aplay at user level?  Thanks.
> >>
> >>John
> >>
> >>
> >>---------------------------------------------------------------------- 
> >>---
> >>Using Tomcat but need to do more? Need to support web services,  
> >>security?
> >>Get stuff done quickly with pre-integrated technology to make your  
> >>job easier.
> >>Download IBM WebSphere Application Server v.1.0.1 based on Apache  
> >>Geronimo
> >>http://sel.as-us.falkag.net/sel? 
> >>cmd=lnk&kid=120709&bid=263057&dat=121642
> >>_______________________________________________
> >>Alsa-devel mailing list
> >>Alsa-devel@lists.sourceforge.net
> >>https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >
> >-- 
> >Federico Grau
> >Free Software Developer and Sysadmin
> >Radio Free Asia
> >2025 M Street, NW
> >Suite 300
> >Washington, DC  20036
> >202-587-2046  Telephone
> >202-721-7468  Facsimile
> >CONFIDENTIAL COMMUNICATION
> >This e-mail message is intended only for the use of the addressee and  
> >may
> >contain information that is privileged and confidential.  Any  
> >unauthorized
> >dissemination, distribution, or copying is strictly prohibited.  If you
> >receive this transmission in error, please contact network@rfa.org.
> >

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
