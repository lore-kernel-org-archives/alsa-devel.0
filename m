From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [alsa-devel] [PATCH] Improved support
	for	different	bt87x	board configurations
Date: Sat, 08 Sep 2007 01:33:36 +0100
Message-ID: <1189211616.6721.90.camel@areia>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
	<1188975275.6158.34.camel@areia>
	<Pine.LNX.4.58.0709050120490.31808@shell4.speakeasy.net>
	<s5h3axtv30n.wl%tiwai@suse.de> <1188988371.6158.43.camel@areia>
	<Pine.LNX.4.58.0709051523390.31808@shell4.speakeasy.net>
	<1189109832.10203.30.camel@areia>  <s5hlkbihw6y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <s5hlkbihw6y.wl%tiwai@suse.de>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, alsa-devel@alsa-project.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

> > Reviewed-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> Thanks, but I have already committed, and don't want to rollback now
> :)
No problem ;)

> BTW, how is this tag supposed to use?

This is a new tag that were agreed to be used informally at KS/2007 :)

The idea behind is to use the following logic:

Signed-off-by: - should be used by the author(s) and the trees for what
the patch passed. A maintainer should add this tag to confirm that he
received a patch by its author or from a sub-subsystem tree (in fact,
sometimes, this tag is abused);

Acked-by: - this simply means that you aren't against some patch;

Reviewed-by: - It means that somebody that are not at the direct
forwarding way of a patch has reviewed and/or tested a patch.

So, in this case, as Trent sent the patch directly to you (even I'm
being C/C), I should use either acked-by (if I'm just ok with this) or
reviewed-by. As I've reviewed the source code, reviewed-by is the better
option.

Also, subsystem maintainers are asked to require at least one
reviewed-by by patch. The idea is to stimulate the community to review
changesets and improve the overall quality of the kernel.

>  On git or Hg, it's hard to
>  change the already committed stuff, especially after openly
>  published...)

What I do here is: I don't change -hg tree. During my -git conversion, I
add such tags that I receive from third parties, even for patches
already published at kernel.org. I only stop adding tags after asking a
git pull.

Here, I'm still using stgit porcelain to allow me to review changesets,
but this is not recommended. Probably, I'll review my procedures.
However, git have already some way for you to edit a message for an
already-edited changeset.

On possible way would be do to this - supposing that you want to edit
the patch that is HEAD - 3 patches from your master branch:

git checkout HEAD~3
git commit -e --amend
	(edit the comments)
git chckout master


I didn't really tested the above procedure, so I would try this on an
experimental tree first.
.
> 
> Takashi

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
