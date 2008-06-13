From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 20:43:27 +0200
Message-ID: <20080613184327.GB1954@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<20080613142526.GB21255@tango.0pointer.de>
	<s5hod65qqhh.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131800160.1798@tm8103-a.perex-int.cz>
	<s5hhcbxqp1y.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131835180.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CFC73244EF
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 20:43:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806131835180.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 13.06.08 18:47, Jaroslav Kysela (perex@perex.cz) wrote:

> > > > What about just providing three pointers: curr_ptr, hw_ptr and
> > > > appl_ptr?  curr_ptr corresponds to the point being played, and hw_ptr
> > > > is the point where the data was already sent to h/w, and appl_ptr is
> > > > the point where the data is filled by user.  The above definitions are
> > > > all combinations of these pointers.
> > > 
> > > But I think that curr_ptr can be managed in drivers, thus invisible to 
> > > user space (except for snd_pcm_delay() propagation).
> > 
> > Ditto for hw_ptr.  Why is it hidden at all?
> 
> Does it improve something to show this pointer to apps? I don't see any 
> reason to show it outside alsa-lib.

As I already pointed out different applications need different kinds
of timing information. Some want to estimate when the next xrun will
happen, other's want the delay that the next write will take to be
played, even other's want how much of the already written data is not
yet played. Even other's want absolute times.

And I do follow Takashi in so far that when you'd just choose to
export the three pointers to userspace, so that they can be queried
atomically everybody can relatively easily calculate from these 'raw'
values what they need.

The problem I see with those 'cooked' values that are currently
exported (i.e. delay and update_avail) is that they only serve a
single purpose and there are so many different ways to use and
especially misuse them, as we have seen in the WINE case. Certainly,
the ptrs can be misused too, but at least all the information the
kernel has that it uses to calculate those 'cooked' values is
available to userspace too, so without too ugly code userspace can
always calculate what is necessary. If you only have a subset of the
cooked stuff and want to calculate the other cooked stuff from it your
in pain.

I think there are two extremes:

a) export the 'raw' info to userspace: the three pointers

b) export the 'cooked' info to userspace in all its variations:
   similar to the API I suggested that would take an enum for
   choosing the right timing parameter the app wants.

Everything in between these extremes would be incomplete.

I could live with any situation of these two. The question is do you
trust userspace programmers to use the three pointers correctly, or do
you want to make sure they get things right with the enum API?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
