From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Writing a mini ALSA driver from scratch
Date: Wed, 25 Aug 2004 22:09:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <412CF1DE.1060203@sun.ac.za>
References: <E1BzmB2-00014C-RI@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BzmB2-00014C-RI@sc8-sf-list2.sourceforge.net>
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

A student of mine is working on an audio capture driver for an ARM Linux 
system. The ARM (AT91RM9200) processor talks via SSC and I2S to a set of 
audio ADCs that capture 6 channels of 24-bit 192 kHz audio (no playback 
involved).

The application is real-time sound logging (latency not important). I 
figured it might save the application developers some hassles by 
presenting this capture device as a soundcard to Linux. That way it may 
simplify realtime processing by using standard callback interfaces such 
as JACK (less apps to write!).

My questions to the ALSA gurus are:

1) Is this a sound approach? (sorry, that slipped out)

2) Is it possible to write a bare-bones ALSA driver with only capturing 
functionality (no playback/mixer)? What are the bare essentials that 
make up an ALSA driver? (I'm worried about overkill)

3) Are there any existing drivers that could serve as a good template 
for a minimalist driver (I'm ignoring issues such as ISA/PCI etc.), to 
see how viable this option is? I was thinking maybe Gravis Ultrasound or 
such...

4) Is an ALSA driver even possible on ARM (dunno much about mmap and the 
like)?

Thanks in advance for any tips. I was thinking of ploughing back any 
generic stuff along the way (like the AT91 SSC support).

Ludwig Schwardt


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
