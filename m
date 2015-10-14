From: James Cameron <quozl@laptop.org>
Subject: Re: Sound not working after new kernel installed
Date: Thu, 15 Oct 2015 09:43:52 +1100
Message-ID: <20151014224352.GI27911@us.netrek.org>
References: <trinity-85f74570-9abc-486a-82c3-4f14c20d1ad0-1444825379497@3capp-webde-bs37>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id D3275265232
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 00:44:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <trinity-85f74570-9abc-486a-82c3-4f14c20d1ad0-1444825379497@3capp-webde-bs37>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Wolk <mistervertigo@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 14, 2015 at 02:22:59PM +0200, Simon Wolk wrote:
> I am using an old Benq notebook (Joybook S73) mit Xubuntu
> 15.04. When I installed a new kernel (then 3.19.0-16, but now I am
> using 3.19.0.28) the sound on the speakers stoped working and there
> were no more audible sounds. With headphones plugged in and a the
> highest possible volume I could hear very silent the music played on
> the PC.
> 
> Up to Kernel 3.2.0-70 the sound worked fine.

Does 3.2.0-70 still work fine?

A friend's laptop had an electrostatic discharge or electrical event
that damaged the audio codec chip, taking out the headphone detect and
headphone amp, and it showed almost same symptoms as you describe.  On
that laptop, patching the kernel to force the headphone not present
fixed playback from speakers.  I'm not suggesting that, but if you can
say the old kernel still works fine you can exclude damage as cause.

That leaves you with looking at the difference between 3.2.0 and
3.19.0, for the driver in use.

Try other kernels between the two, to figure out which kernel
introduced the change.

-- 
James Cameron
http://quozl.linux.org.au/
