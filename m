From: Dave Zielinski <DZielinski@righthandtech.com>
Subject: Pops, Clicks on Capture w/ S/PDIF, Cirrus Logic CS4207,
	HDA
Date: Wed, 11 Aug 2010 19:20:19 -0500
Message-ID: <69FA8BA3444DD443841AF768F2F6C65A12490213C9@SERVER2.righthandtech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from remote.righthandtech.com
	(173-161-64-18-Illinois.hfc.comcastbusiness.net [173.161.64.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 13F5F24383
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 02:20:16 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
   I have a custom platform with a Cirrus Logic CS4207 connected to an HDA bus of a Intel US15W & Atom processor.  I'm trying to capture audio from the S/PDIF input of the CS4207 and getting pops & clicks.   I'm not sure if there is another platform out there that utilizes the S/PDIF input of this chip so this might be new although usage of US15W shouldn't be anything new.  

Software-wise I'm running: 
Moblin release 2.1
Advanced Linux Sound Architecture Driver Version 1.0.20.
2.6.31.6-17.10.moblin2-custom - The kernel is built to include a back ported version of the 2.6.32 Cirrus Logic patch for HDA.  I guess we backported a checkin from the nearest stable kernel release.   We had to do a couple of things to get it to work like comment a line in the driver so that it ignores the digital mic input as it seems the driver only supported one digital input and during the parsing the private data (NID and such) were getting clobbered when the DMIC node is parsed.  As a result the capture was using the wrong node.  position_fix=1 had to be applied also because there was a repeating audio issue.  

So now we're getting some audio but it comes with pops and clicks when we try to capture.  An analysis of the captured stream shows there are corruptions of the data that are 8192 frames apart which I believe are the 4096 frame period boundaries (although tough to know for sure).  When the corruption occurs there seems to be 5 to 7 frames that are screwed up.   Also worth noting: these same exact samples appear in the stream at a prior location so I think its old buffer data.   My guess is that we're reading the buffer before the "writer" was done writing it.  

I've tried to mess around with the buffer size & period size (although buff was always == per*4); tried mmap;  I also tried messing around with the bdl_pos_adj option in the driver.  It sounded like maybe this was most likely to solve the problem.  But that didn't have any effect.  So I started studying the code and realized there was going to be some learning curve here so I was hoping someone could point me in the right direction to help resolve this.

Thank you!
Dave Z.

Here are my capture settings:

Recording raw data 'test.raw' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Hardware PCM card 0 'HDA Intel MID' device 1 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
