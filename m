From: Doug <nostar@comcast.net>
Subject: EZ8 ADAT I/O card (ICE1712 chipset)
Date: Fri, 30 Jan 2004 04:05:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401A1E49.6030309@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I finally decided to start working on ALSA support for my EZ8 card 
(www.event1.com) and man, did I get lucky.  I am brand new to device 
driver development altogether, so my main concern here is learning how 
everything works in addition to just getting the EZ8 card to work.

Out of the box, the snd-ice1712 driver recognized it as a Hoontech DSP24 
card (I also have a Delta 1010LT installed):

cat /proc/asound/cards
0 [M1010LT        ]: ICE1712 - M Audio Delta 1010LT
                      M Audio Delta 1010LT at 0x9000, irq 11
1 [DSP24          ]: ICE1712 - Hoontech SoundTrack Audio DSP24
                      Hoontech SoundTrack Audio DSP24 at 0xa000, irq 11

With this configuration I am able to send PCM out to all 8 channels but 
no input.  I refer to my ldd2 book, "Writing an ALSA Driver" document, 
and ice1712 src to learn how the cards are identified.  I found that the 
  subvendor/subdevice ID @ 0x2c-0x2f are the same between the EZ8 and 
the Hoontech DSP24 (0x12141217).  As an experiment I made the following 
change to line 32 of hoontech.h:

#define ICE1712_SUBDEVICE_STDSP24		0x12141216

Basically just changing the ID to a bogus number.  As I expected it now 
was identified as a generic device:

cat /proc/asound/cards
0 [M1010LT        ]: ICE1712 - M Audio Delta 1010LT
                      M Audio Delta 1010LT at 0x9000, irq 11
1 [ICE1712        ]: ICE1712 - ICEnsemble ICE1712
                      ICEnsemble ICE1712 at 0xa000, irq 11

And bonus!  Everything now works, all 8 channels work in and out and in 
full duplex.  So far I have tested 48Khs and 44.1Khz sending 8 channels 
up and down at the same time w/ ardour, and envy24control displays all 
of the levels accurately.  It appears to be fully functional.  I of 
course will be testing it out much more.

Questions:

Is this common for PCI device subid's to overlap?  If so, is there a 
preferred method of further identification?  I was looking at the 
configuration space for something else that could be used to identify a 
device, like maybe the class code area at 0x09-0x0b?

I see some MODULE_PARAM macros in ice1712.c, but I am still unclear on 
their exact usage.  Is there already provisions in the driver to force 
generic via a module parameter?

I would like to continue further with this to add the EZ8 card to the 
list of 'supported' devices for this driver, again mainly for my 
interest in learning about device driver development and linux audio.  I 
contacted Event about releasing documentation some time ago before I 
realized how easy this was going to be, to no avail.  I guess my 
question to the ice1712 author is, how is this done?  May I add code 
that finds a way to uniquely identifies the EZ8 card and registers it 
appropriately?  If I succeed and it meets your aproval, would it be 
added to your driver source?

-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
