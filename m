From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Tue, 01 Apr 2003 09:49:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E190MyX-0001yP-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0304011557190.1350-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 01 Apr 2003 16:08:01 +0200."
             <Pine.LNX.4.44.0304011557190.1350-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Ok, I've added the dimension description to the info structure. Although 
>it is completely irrelevant to data transfers.
>
>Also, I've implemented multi element in the kernel space to save memory 
>and it makes the searching faster. The reference code is in the trident 
>driver. I'll recode other drivers containing many "same" controls to use 
>this method later.
>
>The user space applications won't notice any changes.

please don't do the hdsp yet. thomas will be sending a big patch for
the hdsp today or tomorrow. it will make merging easier.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
