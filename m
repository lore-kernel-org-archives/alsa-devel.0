From: John Covici <covici@ccs.covici.com>
Subject: Re: modprobe fails for via82xx in alsa-0.9.3a
Date: Thu, 22 May 2003 07:29:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3u1bn5ieg.fsf@ccs.covici.com>
References: <m3smr8vasr.fsf@ccs.covici.com> <s5hfzn8va58.wl@alsa2.suse.de>
	<16075.25666.840544.292981@ccs.covici.com> <s5h7k8kv7xd.wl@alsa2.suse.de>
	<16075.32553.785487.478126@ccs.covici.com> <s5h4r3os56r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r3os56r.wl@alsa2.suse.de> (Takashi Iwai's message of "Wed,
 21 May 2003 17:14:04 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am not sure what you mean -- before I run /etc/init.d/alsasound
there are no snd modules at all, so what would modprobe -r
snd-page-alloc do for the situation?

on Wed, 21 May 2003 17:14:04 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 21 May 2003 09:29:13 -0400,
> John covici wrote:
>> 
>> Here is what I got when I tried to install-- note the page-alloc
>> module is there:
> (snip)
>> done
>> Module                  Size  Used by    Not tainted
>> snd-page-alloc          5932   0 
>
> and what happens if you run "modprobe -r snd-page-alloc" and
> "/etc/init.d/alsasound start"?
>
>
> Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
