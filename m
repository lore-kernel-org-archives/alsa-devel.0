From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: tons of false positives because of
	snd_ctl_find_id()
Date: Fri, 2 Feb 2018 12:57:28 +0300
Message-ID: <20180202095728.4e2pfy2lwcprwpyb@mwanda>
References: <20180202082903.GA11023@mwanda>
 <43521b22-dfda-ff5f-5857-0d1a8ae639f5@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C5E9266EEB
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 10:57:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <43521b22-dfda-ff5f-5857-0d1a8ae639f5@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 02, 2018 at 06:07:14PM +0900, Takashi Sakamoto wrote:
> 
> In a design of ALSA control core, each element can be pointed according
> to data of 'struct snd_ctl_elem_id'. There're two independent ways to
> indicate arbitrary element:
>  1. by 'numerical ID' (.numid)
>  2. by a combination of 'interface' (.iface), 'device' (.device),
>     'sub device' (.subdevice), 'name' (.name) and 'index' (.index).
> 
> For our information, in ALSA control core, some elements with the same
> attributes are managed by data of 'struct snd_kcontrol'. I call it as
> 'element set'. The value of '.index' represents offset from the first
> element in the element set for a target element.
> 
> I don't get your concern clearly. But it's my pleasure that the above
> information will help you if you missed the two ways.
> 

Right.  Thanks.  I understood all that...

I've actually figured out a hack that will probably work fine to fix my
issue.  Smatch provides a way to hand edit the cross function DB:
http://repo.or.cz/smatch.git/blob/HEAD:/smatch_data/db/fixup_kernel.sh
I can probably solve this by adding a few lines of code to that file.
I'm testing it now.

What I was trying to say was even though we don't need to check .index
since we're not using it, it would simplify static analysis if we would
would set it to zero.  It shouldn't hurt anything since we're not going
to use it.

Anyway, leave it for now because I've got this easier hack around.

regards,
dan carpenter
