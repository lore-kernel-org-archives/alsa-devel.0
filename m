From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA Leaking memory
Date: Mon, 26 Nov 2007 08:17:11 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711260811410.7571@tm8103.perex-int.cz>
References: <20071125214111.GA20742@tango.0pointer.de>
	<Pine.LNX.4.61.0711252254250.7688@tm8103.perex-int.cz>
	<20071125221004.GA23860@tango.0pointer.de>
	<Pine.LNX.4.61.0711252321470.7688@tm8103.perex-int.cz>
	<20071125223759.GA26382@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E59CC24755
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 08:17:12 +0100 (CET)
In-Reply-To: <20071125223759.GA26382@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> On Sun, 25.11.07 23:23, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > > > I cannot reproduce here and from first glance, the error 
> > > > path in snd_config_hook_load_for_all_cards is good.
> > > 
> > > I don't fully grok the code of that function
> > > (snd_config_hook_load_for_all_cards()), but from *my* first glance I see
> > > that snd_determine_driver() allocates the string. Immediately after
> > > that call there are at least two "continue"s which will cause immediate
> > > jumping to the next iteration of the loop this whole code lives in,
> > > without ever freeing the string.
> > > 
> > > Or am I blind or missed something?
> > 
> > No, I'm blind (seeing and associating continue to inner while) ;-) Thanks 
> > for notice. This commit should fix the problem:
> > 
> > http://hg.alsa-project.org/alsa-lib/rev/c8aa952a4579
> 
> Hmm, I still don't fully grok the function, but doesn't this commit
> change the behaviour of the function quite a bit?
> 
> I am not sure due to what kinds of errors snd_config_get_string() or
> snd_config_search() might fail, but the names of those functions sound
> a bit like configuration errors might be one reason for the
> failure. Before this commit, on such an error the code would just go
> ahead with the next card. Now, on such an error the loop is terminated
> immediately. Sounds like a big change in behaviour to me.

I don't see a change in behaviour. The __err section just frees only 
fdriver variable (private_data is NULL and err is >= 0 - see line 2896). 
Because card >= 0 (2896 line), while on line 2923 will continue (thus next 
card will be processed too). I hope I've not overlooked something, too.

> Any idea on that other valgrind bt I posted? Some leak with
> snd_config_make() involved?

Please, give use a simple testcase. This issue might be difficult to 
investigate without it.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
