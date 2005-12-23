From: Alexandr <spiro@demiart.ru>
Subject: Re: 1.0.11rc1: still problem with alsamixer ?
Date: Fri, 23 Dec 2005 22:11:02 +0200
Message-ID: <43AC59D6.609@demiart.ru>
References: <43A5728E.8030103@demiart.ru> <s5h4q51xf42.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------040801080708090602010503"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q51xf42.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040801080708090602010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>At Sun, 18 Dec 2005 16:30:38 +0200,
>Alexandr wrote:
>  
>
>>So. I update my alsa-drivers, -lib , -utils to 1.0.11rc1 - right now my
>>Live 5.1 detect correctly, but problem with alsamixer is stay:
>>
>>kernel 2.6.14 , when i execute "alsamixer" get a next message:
>>
>>ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Front Playback 
>>Volume',0,0,0) appears twice or more
>>
>>alsamixer: function snd_mixer_load failed: Invalid argument
>>
>>and alsamixer don't run, same with amixer.
>>
>>And silence from my rear speakers after update, early i has a copy of
>>front speakers on it.
>>    
>>
>
>Make sure that you have no other libasound.so.  For example, FC4
>installs its own one to /lib while alsa-lib package installs to
>/usr/lib as default.
>
>
>Takashi
>  
>
I have only one libasound.so:

# locate libasound.so
/usr/lib/libasound.so
/usr/lib/libasound.so.2
/usr/lib/libasound.so.2.0.0



--------------040801080708090602010503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Takashi Iwai wrote:
<blockquote cite="mids5h4q51xf42.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">At Sun, 18 Dec 2005 16:30:38 +0200,
Alexandr wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">So. I update my alsa-drivers, -lib , -utils to 1.0.11rc1 - right now my
Live 5.1 detect correctly, but problem with alsamixer is stay:

kernel 2.6.14 , when i execute "alsamixer" get a next message:

ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Front Playback 
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument

and alsamixer don't run, same with amixer.

And silence from my rear speakers after update, early i has a copy of
front speakers on it.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Make sure that you have no other libasound.so.  For example, FC4
installs its own one to /lib while alsa-lib package installs to
/usr/lib as default.


Takashi
  </pre>
</blockquote>
I have only one libasound.so:<br>
<br>
# locate libasound.so<br>
/usr/lib/libasound.so<br>
/usr/lib/libasound.so.2<br>
/usr/lib/libasound.so.2.0.0<br>
<br>
<br>
</body>
</html>

--------------040801080708090602010503--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
