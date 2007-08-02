From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: Will the real alsa wiki please stand up?
Date: Thu, 02 Aug 2007 20:15:44 +0200
Message-ID: <46B21F50.60306@ingomueller.net>
References: <200707270940.45326.linux@audioscience.com>	<s5hejiuw5fq.wl%tiwai@suse.de>	<200707312154.54926.linux@audioscience.com>
	<s5hfy32rtgc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server2.internet4ever.de (unknown [212.112.224.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE7D24336
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 20:15:55 +0200 (CEST)
In-Reply-To: <s5hfy32rtgc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Hi!

Takashi Iwai schrieb:
>> As far as migrating the website on to this wiki, it would be very helpful to 
>> have a list of the source pages and their wiki equivalents that need 
>> migrating, otherwise it is very hard for a volunteer to pick a page and do 
>> it. E.g.  page [[WebMigration]] contains
>>
>> Volunteers need to migrate these pages.
>> Pick a page below, and create the matching wiki page. Once you have done this, 
>> delete the line from here
>>
>> [http://alsa-project.org/applications.php]  [[Applications]] 
>> ... etc
> 
> Yes, that's a good idea.  Care to add it on the top?

I agree with that, too. My question: who knows the current ALSA web site
well enough to fill this list?

>> If the (currently active) contributors to the developer wiki agreed, I'd be 
>> willing to do the grunt work of moving the pages.
> 
> That'd be greatly appreciated.
> 
>> but the page 'owners' might 
>> prefer to do the copy and keep the  authorship intact...
>>
>> JamesCourtierDutton 15 pages
>> LiamGirdwood 2 or 3 pages
>> ClemensLadisch 1 page
>> NormanSchleicher 2 pages
>> JohnUtz 3 pages
>> JaroslavKysela 5 pages
> 
> Any of you have objections about this?
> (sorry I couldn't find Norman's address...)

When I moved the unofficial wiki from an old wiki software to a new
MediaWiki wiki, we decided that it was not worth the extra effort to
keep the authorship intact. Instead, there is a note on the wiki's about
page which linked to a mirror of the old wiki.

If it is possible to track down the authors (like you did above), you
could also just list them on an extra page (maybe "AlsaWiki:Authors")
showing the contributions of these authors to the old wiki. Then,
whenever you move a page to the new wiki, you could link to this page in
the comment ("Moved from old wiki. For details about authorships see
[[AlsaWiki:Authors]].").

>> And, in the official wiki,  would we want a separate Development: namespace?
>> Something the wiki-master needs to create.
>> or is a Development: category a better way to go.
> 
> I think the catgoery should suffice.  But I'm no Wiki expert al all,
> so would like to hear from other skilled guys.

Quote from http://meta.wikimedia.org/wiki/Help:Namespace_manager:
"Generally, namespaces should not be used to categorize content of the
same type -- that is what categories are for." On the other hand, new
namespaces should be created, "if you have a type of content which you
feel is substantially different from the content in the existing
namespaces". Im not sure whether this is the case with the developer
content...

Also, there are some technical things that come along with using a
namespace:

* A different namespace could have a different visual appearence to be
distinguished from other namespace (see
http://www.mediawiki.org/wiki/Manual:Using_custom_namespaces#Custom_colors_for_custom_namespaces)

* A namespace can be searched exclusively which can't be done by a
category. Analogicly, the simple search can be set to only search the
"Main:" namespace (default) or more namespaces.

The downside of a namespace is, that they can only be configured by
administrators (changig config files manually). As this has only to be
done once, I think that shouldn't be that much of a problem.

I think, the choise of using a namespace or a category comes down to the
question how different the content and its audience is. If it is really
different, it should be excluded from the default search (so newbies
won't stumble on it by accident), distinguished visually and so on. In
that case, a namespace is what we need. If it makes sense to be
integrated with the rest of the wiki, a category is the better choise.
Unfortunately, I don't know the content of the two wikis well enough to
make that choise...

>> At the end of this migration, we'd be down to 2 wikis, both MediaWiki, so a 
>> future merge would be easier(???)

Indeed, there are in- and export functions since a couple of version of
mediawiki.

>> ====================================
>> Integrating official and unofficial is a bridge to cross...later.
>> However, setting up some interwiki mappings between the 2 would make it easier 
>> to crosslink:
>>
>> http://meta.wikimedia.org/wiki/Help:Interwiki_linking
> 
> Thanks for the information!
> 
> 
> Takashi

I'm happy that someone initiated a discussion on that topic again. Maybe
I can get motivated to join the merging process after I finished my
exams :-)

Greets, Ingo
