From: Joe Hsu <nagual.hsu@gmail.com>
Subject: About bt87x
Date: Wed, 9 Mar 2005 19:00:49 +0800
Message-ID: <7fe20599050309030051e073c3@mail.gmail.com>
Reply-To: Joe Hsu <nagual.hsu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello:

    I have a bt878 audio device. It can work only at digital 
sample rate 8000HZ from TV tuner source. For this bt878 audio
device, we have modified some source of the kernel module
btaudio. The only difference between the original module and
the modified one is the value of GPIO_DMA_CTL register. And
this new btaudio module works for me.

   Now, I have tried to modify alsa bt87x to work for me.
I add another pci_device_id to represent 8000HZ sample rate. I changed
three fields of snd_bt87x_digital_hw
to represent mono 8000HZ. But still don't work. And then
I changed the value of GPIO_DMA_CTL register as I did
in the btaudio module. Well, it worked in slow motion
when I played the captured pcm data. Can somebody
give me some hints? Thanks 

--
The sun is shinny but the ice is slippery.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
