From: Kasper Souren <kasper@303.nu>
Subject: Re: yes.. [was 1869 trouble with snd-es18xx
Date: Fri, 28 Jun 2002 01:39:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1BA23A.5060207@303.nu>
References: <200206271408.g5RE8VD25834@post2.fast.net> <3D1B1D7A.4070602@303.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
Cc: Rubikz <rubikz@anonymity.fr.st>, =?ISO-8859-15?Q?=22Jos=E9_Andr=E9s?= =?ISO-8859-15?Q?_Mart=EDnez_S=2E=22?= <jose_andres@softhome.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Finally I managed to get ALSA running properly on my Compaq Armada 3500 with 
an es1869 soundchip. The problem was apparently an IRQ DMA problem. I read 
the datasheet of the es1869 and there I found that it's best to have the 
first DMA channel set to 1 and the second DMA set to 0, 1 or 3. I haven't 
found anything about IRQ settings, but I tried irq 9, which didn't work, and 
now I'm using irq 5. However, Jose Andres Martinez runs the es18xx driver on 
his Armada 3500 with irq 9.

The second DMA channel used to be 5. And the OSS sb driver worked perfectly, 
just like the Windows 98 and 2000 drivers. So that's pretty strange. On 
Windows I even managed to have full duplex. Haven't tried that yet.

Maybe someone can add this information to the ALSA documentation somewhere. 
The ALSA HOWTO might be a good place? Jorn?

greetz,
Kasper


P.S. me happy now :) finally I can use ALSA and JACK :)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
