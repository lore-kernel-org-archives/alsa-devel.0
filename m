From: Gerard Janssen <g.janssen@its.tudelft.nl>
Subject: How to address all S/PDIF output ports on a SBLive!
Date: Sat, 18 May 2002 17:13:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ac5rd3$ecb$2@main.gmane.org>
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
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I would like to send multiple digital audio streams to different SPDIF
outputs of my soundcard (SBLive! Player 1024, CT4830, Rev. 6). This
soundcard has a 40 pins external audio connector with four SPDIF outputs
indicated as SPDIF#0 - 3.
 
When I use the "front" channel in ALSA, this signal is also send to the
SPDIF#0 output. When I use "iec958:AES0=0x4 , AES1 = 0x82 , AES2 = 0x0 ,
AES3 = 0x2", the signal is send to the SPDIF#1 output. Both SPDIF outputs
can be addressed simultaneously with different stereo audio streams.
However, I have not been able to send a signal to the SPDIF#2,3 outputs
using ALSA. 
Under Windows98, when I have installed the EMU-APS driver with the SBLive!
card, I can choose each of the four SPDIF outputs to send a stereo signal to. 

How can I address the SPDIF#2,3 outputs under ALSA? Is it possible to send
more then 2 (preferably four) stereo audio streams to the SPDIF outputs.
 
I hope somebody can help me to solve this problem.

Thanks in advance,

Gerard Janssen 



_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
