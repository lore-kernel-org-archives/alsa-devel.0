From: Paul Davis <pbd@op.net>
Subject: Re: HDSP -- how to configure modules.conf?
Date: Wed, 15 May 2002 18:24:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1787AL-00007A-00@usw-sf-list1.sourceforge.net>
References: <000201c1fc58$d4c73070$ac1f830a@ico>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 15 May 2002 17:38:19 EDT."
             <000201c1fc58$d4c73070$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> How did you compile? I mean right from the very beginning ... I've
>> obviously been building from CVS all along, and I assume that Jaroslav
>> did a rebuild after he committed the changes.
>> 
>> --p
>
>Thank you for your continuous help!

well, after some more digging, it seems that the problem is the
acinclude file in alsa-driver, which is what defines the list of cards
that exist and sets them up to be compiled.

i believed that it was stored in CVS, but it apparently is not. it
needs modifications that i believe i sent to jaroslav, but because its
not in CVS, i did not ("cvs -z3 diff" didn't notice it).

instead, it seems that acinclude is built from several files called
Module.deps by a utility call mod-deps. i don't understand when its
built. 

jaroslav or takashi or someone who understands how this works: would
you please modify Modules.dep or whatever needs to be done to fix this
issue? the existing Modules.dep file doesn't contain entries for the
H-DSP, and it continue to name snd-rme9652-mem, rather than
snd-hammerfall-mem. 

it worked for me because i had edited acinclude by hand, and for some
reason that i don't understand it was never rebuilt by the automated
process (which would have removed the hdsp entries, i think).

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
