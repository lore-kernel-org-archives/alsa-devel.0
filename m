From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: help for a levelmeter
Date: Wed, 16 Oct 2002 22:16:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DADC922.5000808@club-internet.fr>
References: <20021015224039.59921.qmail@web12207.mail.yahoo.com>
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
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

karsten wiese wrote:
> Laurent Georget: 
> 
>>  Hello,
>>
>>I 'd like to make a levelmeter program which would
>>display sound card
>>input/output
>>while the audio device is opened by another program.
>>I tried to use copy
>>plugin  , but now (since 0.9.0rc3 ) the
>>"snd_pcm_copy_open" give a "implicit
>>declaration of function"
> 
> hmm, it is still declared in
> alsa-lib/include/pcm_plugin.h ...?
> 

Hmm..  my fault, just have to include pcm_plugin.h

> 
> 
> (there is a jack meter client @
> http://plugin.org.uk/meterbridge/)
> 
> 
> regards, karsten

Thanks for responding!

Ok , I have seen it , but  it works with jack compatible programs, and 
the levelmeter
i'm aiming at should work with Glame , as an example .

Anyway I can now try to experiment the copy_plugin : would you know some 
program using
this plugin, which would make the thing easier !

Thanks again

Laurent





-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
