From: "Matthew Williams" <mw01@wilber.pointclark.net>
Subject: Re: Need for a new ALSA developer?
Date: Fri, 28 Mar 2003 01:00:22 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <007701c2f469$35907c00$3200a8c0@MATT>
References: <E18wRnN-0002So-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

["My name is Robert and I'm very much interested in working on ALSA Project
with
you. I primarily would like to develop a new driver for a souncard, which is
not supported by ALSA yet, perhaps some USB stuff from Midiman?"]

Gday Robert,
I'm not involved in Alsa development at all, but I do have a suggestion for
you on what you could work on. My friend is a professional music producer
and currently uses Windows 2000 and programs such as CalkWalk, CuBase,
ReCycle, SoundForge, etc. He would like to start using Linux and
unfortunately there is only one piece of hardware that he has that is
currently unsupported in Linux. This unsupported piece of hardware is what
is holding him back from switching to Linux.

That piece of hardware is the Emagic Unitor8/AMT8 Mk II which connects to
his computer via the serial port. The Emagic Unitor8/AMT8 Mk II is capable
of connecting to computers via USB, RS232 and RS422, and looks like this:
http://www.emagic.de/products/hw/unitor/index.php?lang=EN

I emailed Emagic asking about Linux drivers for it and they referred me to
this page:
http://www.math.tu-berlin.de/~sbartels/unitor/
Unfortunately, that page hasn't been updated since the May 28, 2000. I've
emailed all 3 of the developers and have not heard back from them. Their
first working version of the alsa driver had only support for USB which is
not good as my friend has the serial port version.

I had a search through the alsa-devel archives and found that Manush
Dodunekov had developed a patch for alsa 0.9.0rc1 which was a serial driver
for unitor8/amt8:
http://sourceforge.net/mailarchive/message.php?msg_id=1510131
That version of alsa 0.9.0rc1 is almost a year old. Also it appears that
Manush Dodunekov hasn't done any more work on that driver.

Emagic has provided complete documentation (currently available only in
German language) of the serial/USB communication protocol of the
Unitor8/AMT8 both MkI and II. This info can be found on this page:
http://www.math.tu-berlin.de/~sbartels/unitor/
direct link here:
http://www.math.tu-berlin.de/~sbartels/unitor/unitor8_doc.txt
However that page is in a Unix text format ans if you try using and web
translation, you will lose the formatting. I've downloaded the file and
converted it into a DOS text format and this will work with web translation.
A good web translation is at:
http://intertran.tranexp.com/
scroll to the bottom and for step 1 choose "German" "English". For step 2
paste this url in:
http://wilber.pointclark.net/alsa/unitor8amt8mkimkiiserialusbdoc.htm
and for step 3 hit the "Translate" button.

So what could you work on? My suggestions are:
- Update Manush Dodunekov's alsa 0.9.0rc1 patch so it now works and applies
to the latest alsa version alsa-0.9.2.
- Merge the USB driver found on this webpage
http://www.math.tu-berlin.de/~sbartels/unitor/ with Manush Dodunekov driver.
- Make sure the driver fully implements and is compliant to the official
complete documentation of the serial/USB communication protocol of the
Unitor8/AMT8 both MkI and II. Manush Dodunekov serial driver does not yet
support send-to-all output port and catch-all input port (port 0 in the
windows driver).
- Investigate different driver models and implementations re: ["
 http://sourceforge.net/mailarchive/message.php?msg_id=1510131
 The driver is heavily based on serial-u16550.c, which may be the wrong
 concept. A more correct concept seems to have a generic-serial.c and
 generic-usb.c, which only implement a communication channel. The interface
 drivers could then load&use them and only implement their own
 init/port-select/whatever dialect. Lots of MIDI interfaces come with both
 USB and serial connectors nowadays. Any thoughts on this?

 http://sourceforge.net/mailarchive/message.php?msg_id=1515201
 Ok. I'll give a userspace unitor8-driver a try then.
 "]

What do you think? Also which country are you in? In your country it might
be legal to reverse engineer.

Hoo Roo,
Wilber




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
