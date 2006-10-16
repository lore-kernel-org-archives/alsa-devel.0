From: EmIScA <emisca@email.it>
Subject: Re: Asus P5LD2 SE AD1986A snd-hda-intel model and
 master volume control
Date: Mon, 16 Oct 2006 12:14:36 +0200
Message-ID: <45335B8C.5010104@email.it>
References: <45321DC5.5050608@email.it> <s5hfydobndm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0841963696=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfydobndm.wl%tiwai@suse.de>
Message-ID: <20061016101439.307916@fra1.cab.uniroma3.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0841963696==
Content-Type: multipart/alternative;
	boundary="------------050209000204060306060707"

This is a multi-part message in MIME format.
--------------050209000204060306060707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I realized that... My problem is that gnome mixer, kmix, use 
headphone as master volume control.
I've read about the softvol plugin, how I can setup it to simulate the 
master control?
Can I rename a mixer control?

Takashi Iwai ha scritto:
> At Sun, 15 Oct 2006 13:38:45 +0200,
> EmIScA wrote:
>   
>> To get sound from my Asus P5LD2 SE motherboard (which uses AD1986A
>> codec) I had to set model=3stack manually using alsa 1.0.13.
>> It works well, but I have no master volume mixer control, why? There is
>> a Headphone control which don't control anything. Perhaps I can set the
>> volume using the Front control. Is it fixable? Can I  map Front as
>> Master? Can I create a master control that controls front, surround,
>> center and lfe together?
>>     
>
> AD1986A has no real master control.  That is, front, rear and CLFE
> have separate volume controls but no master control indeed.
>
> The PCM control affects all channels (intentionally done so).
>
>
> Takashi
>
>   


--------------050209000204060306060707
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Ok, I realized that... My problem is that gnome mixer, kmix, use
headphone as master volume control.<br>
I've read about the softvol plugin, how I can setup it to simulate the
master control?<br>
Can I rename a mixer control?<br>
<br>
Takashi Iwai ha scritto:
<blockquote cite="mids5hfydobndm.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">At Sun, 15 Oct 2006 13:38:45 +0200,
EmIScA wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">To get sound from my Asus P5LD2 SE motherboard (which uses AD1986A
codec) I had to set model=3stack manually using alsa 1.0.13.
It works well, but I have no master volume mixer control, why? There is
a Headphone control which don't control anything. Perhaps I can set the
volume using the Front control. Is it fixable? Can I  map Front as
Master? Can I create a master control that controls front, surround,
center and lfe together?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
AD1986A has no real master control.  That is, front, rear and CLFE
have separate volume controls but no master control indeed.

The PCM control affects all channels (intentionally done so).


Takashi

  </pre>
</blockquote>
<br>
</body>
</html>

--------------050209000204060306060707--


--===============0841963696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0841963696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0841963696==--
