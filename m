From: Gerard Janssen <g.janssen@its.tudelft.nl>
Subject: How to address the S/PDIF output ports on a SBLive!
Date: Fri, 17 May 2002 15:17:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <acqdu6$ecp$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to send multiple digital audio streams to different SPDIF
outputs of my soundcard (SBLive! Player 1024, CT4830, Rev. 6). This
soundcard has a 40 pins external audio connector with four SPDIF outputs
indicated as SPDIF#0 - 3. 

When I use the "front" channel in ALSA, this signal is also send to the
SPDIF#0 output. When I use "iec958:AES0=0x4 , AES1 = 0x82 , AES2 = 0x0 ,
AES3 = 0x2",the signal is send to the SPDIF#1 output. Both SPDIF outputs
can be addresses simultaneously with different stereo audio streams.
However, I have not been able to send a signal to the SPDIF#2,3 outputs.

How do I address the SPDIF#2,3 outputs? Is it possible to send more then 2
(preferably four) stereo audio streams to the SPDIF outputs.
I hope somebody can help me to solve this problem.

Thanks in advance,

Gerard Janssen 


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
