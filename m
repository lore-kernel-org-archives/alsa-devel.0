From: Martin Dausel <dauselm@emt.iis.fhg.de>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: Wed, 12 Nov 2003 18:30:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB26E23.3050903@emt.iis.fhg.de>
References: <200311121701.hACH1c8e021666@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311121701.hACH1c8e021666@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Paul Davis wrote:<br>
<blockquote type="cite"
 cite="mid200311121701.hACH1c8e021666@oud.linuxaudiosystems.com">
  <blockquote type="cite">
    <pre wrap="">Hi,
it seems to me that with alsa 0.9.8 drivers it's not possible to load
snd-rme9652. With 0.9.7c there is no problem. The snd-hdsp driver works
in both versions (i tried both cards with both alsa versions).

error message:
modprobe snd-rme9652
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: init_module:
No such device
modprobe: insmod
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o failed
modprobe: insmod snd-rme9652 failed
    </pre>
  </blockquote>
  <pre wrap=""><!---->
what type of RME hardware do you have? send us the output of lspci -v
  </pre>
</blockquote>
Sorry for the poor information, here comes the rest:<br>
<br>
* the problematic card is the RME Digi9652 (Hammerfall) (rev03)<br>
* the working card is the RME Hammerfall DSP (rev 68)<br>
I tested them seperately.<br>
</body>
</html>



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
