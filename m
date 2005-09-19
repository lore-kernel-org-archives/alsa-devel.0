From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Implement support for display of dB gain
 in alsamixer.
Date: Mon, 19 Sep 2005 20:12:50 +0100
Message-ID: <432F0DB2.7020602@superbug.co.uk>
References: <432D6C3A.4000001@superbug.co.uk> <Pine.LNX.4.61.0509191511290.8552@dhcp73.suse.cz> <s5hirwxw0bo.wl%tiwai@suse.de> <Pine.LNX.4.61.0509191722130.8552@dhcp73.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0509191722130.8552@dhcp73.suse.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> It's also quite good method, but it avoids having multiple blocks with 
> same keys. For example:
> 
> block1-mixer
> key1
> key2
> /block1-mixer
> block2-pcm
> key1
> key2
> /block2-pcm
> 

This might be nice...looks more and more like XML all the time. ;-)

You might laugh, but getting the kernel to simply build an xml file that 
it then sends to user space is not that difficult. Then one could use 
the bloated xml parsers in user space, and therefore keeping the kernel 
small.

We could even have the control get/set using xml as well.
So, the above in xml:

<block1-mixer>
<key1>some value</key1>
<key2>some other value</key2>
</block1-mixer>
<block2-pcm>
<key1>some value</key1>
<key2>some other value</key2>
</block2-pcm>


Now, we would have to allow for the possible dynamic adding and removal 
of controls, for example, when using qlo10k1 to add a new effect to the 
Audigy 2 DSP.

The mixer api does not have to be high performance, and using XML would 
be endlessly extensible and backward compatible.

Another alternative would be to use the sys filesystem to transfer the 
information. The nesting would be handled using subdirectories, and the 
keys themselves would be individual files in the sys filesystem.
So, representing the above, the sys fs would contain a dir containing:
block1-mixer
block2-pcm

In the block1-mixer dir, one would have the files:
key1
key2
and the contents of the file would be the value of that parameter.

The alsa-lib would just scan the sys file system with subdirectories and 
only use the keys it could understand.

Some keys would be read only, some read/write.
I.e. the db scale key would be read only, but the gain variable would be r/w

I think that the kernel would be happier with us using the sys fs 
instead of xml.

The only other thing we have to consider is the mixer events method.

James


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
