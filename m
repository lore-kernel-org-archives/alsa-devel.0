From: Doug <nostar@comcast.net>
Subject: New hardware - New developer / tester
Date: Thu, 18 Dec 2003 06:47:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE193CB.8070308@comcast.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

My goal is to become ridiculously involved in linux audio, mainly (at 
least for now) device driver development.  I have an EZBus audio 
device/control surface/mixer, and an EZ8 ADAT I/O card (www.event1.com). 
  My goal was to write an ALSA driver for the EZ8 card and EZbus for use 
with Ardour/JACK to do 8 track live recording and be a 100% open source 
band (we are currently using XP / Cubase).  The snd-usb-audio works with 
the EZBus already, and how suprised I was to get sound out of the EZ8 
card using the ice1712 driver.  There is some noise there, and neither 
with alsamixer nor envy24control could I get any type of level control. 
  Theres lots that need to be adapted to the EZ8 I think (channel 
assignments/levels, clock source, sample rate, etc), so thats what I 
would like to do as I learn device driver programming and linux audio. 
Right now I'm deep into the Oreilly Linux Device Drivers book, and 
browsing the ALSA developers docs.

So, here are my questions:

Is there a process for registering devices in the matrix and determining 
how 'functional' is enough to be considered 'supported'?  Do I just 
shout loudly, 'EZBus works!' ? :)

Do any of the existing ice1712 developers have chip documentation I 
could have?  Is it allowed / polite / acceptable for me to tear into the 
existing ice1712 code and learn from it, then either use code from it to 
create this driver or add complete EZ8 functionality to the existing driver?

I assume this is the list to ask driver specific questions, which I'm 
sure I will have alot of as I dive into kernel land?

I read the home site asking for testers, I have alot of PC hardware at 
my disposal, do developers just post requests for people to test code as 
the need arises?

Sorry about my generally 'clueless' disposition, but I guess I have to 
start somewhere :)

-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
