From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: alsa09 sound for portable computers
Date: Mon, 08 Apr 2002 15:52:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB1AEBD.203@superbug.demon.co.uk>
References: <3CACBDD6.3060705@superbug.demon.co.uk> <s5helhqmfty.wl@alsa2.suse.de>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>Hi James,
>
>At Thu, 04 Apr 2002 21:55:50 +0100,
>James Courtier-Dutton wrote:
>
>>Hello
>>
>>I have just managed to get alsa09 sound to work on my portable after a 
>>lot of difficulty with neither alsa or oss modules loading.
>>I would like to suggest that we start adding an alsa09 howto for 
>>Portable PC users.
>>It would have: -
>>Name of PC,  sample modules.conf line to use.
>>
>>My old portable is a Toshiba Satellite 4010CDT which is NOT plug and 
>>play sound.
>>
>
>could you try my (updated) alsaconf script for test?
>it's written for suse distribution, but should run on any system with
>pciutils and dialog.
>the file is found at
>	ftp://ftp.suse.com/pub/people/tiwai/alsa9-packages/misc/alsaconf
>
>just run it as root, choose "probe legacy isa chips", then choose
>opl3sa2 from the list.
>
>
>ciao,
>
>Takashi
>
The sound card was a non-plug and play sound card, so I don't think any 
current alsaconf file will help.

For example, the howto for my card would be: -
Go into the BIOS, get the IO and IRQ settings of the sound card.
Enter those IO and IRQ settings in the modules.conf alias file together 
with -isapnp=no.
Then it will work.
I did not know before I started that if the alsa-driver modules are 
compiled with isapnp switched on. You cannot use non-plug and play sound 
cards, without specifically telling the modules.conf alias line that it 
is a non-pnp device.

Cheers
James
