From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Driver Programming
Date: Thu, 25 Nov 2004 17:43:03 +0100
Message-ID: <41A60B97.3010809@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

I want to programm an driver for the Cirrus CS42516. This Codec 
communicates with an ARM9 CPU over 3 I2S channels. I want to use 3 
stereo channels for playing and two stereo channels for receiving the 
data. All three channels are working with the same clock-rate.

I have read the documentation "Writing an Alsa Driver" but I am confused 
about the meaning of PCM Streams and Substreams. What must I declare, 
one PCM Stream with three Substreams or 3 PCM Streams ?

Is there any existing driver with a similar configuration (more than one 
channel)?


Thanks

Klaus



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
