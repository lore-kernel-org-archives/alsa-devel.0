From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: ring buffer pointer accuracy.
Date: Thu, 10 Jul 2003 16:31:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F0D86D0.6040905@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

When an application reads the "avail" or "delay" pcm values: -
1) how accurate are they?
2) does the accuracy depend on the sound card driver being used.

The reason I ask this, is that I am going to be writing an alsa driver 
for bluetooth headsets.
With bluetooth headsets, sound is sent to the bluetooth headset inside a 
packet.
This packet is 27 bytes long, and contains 24 audio samples (8 bit mono, 
8000hz) and 3 bytes header.
This would mean that the "avail" and "delay" pointers will only be 
updated once every 24 samples, and will always go in 24 sample increments.
This means that the "avail" and "delay" pointers are only accurate to 
the nearest 3 ms.

Do any other alsa drivers suffer from this, or are they all sample 
accurate and updated as each sample is sent to the speakers.

It would be nice for the application to be able to determine how 
accurate the "avail" and "delay" pointers are.
If an application is trying to syncronise video to audio, it will need 
to know how accurate the snd_pcm_delay() pointer is.
I.E. Is snd_pcm_delay() updated as each sample is output to the 
speakers, or is it only updated as each block of 24 samples are output.
As you can see, if the application trys to syncronise to sample 
accuracy, it will fail badly with bluetooth headsets, but if the 
application can be told by alsa that it should only try to syncronise if 
it is more that 24 samples out of sync, the problem will be solved.

Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
