From: Chuck Winters <cwinters@atl.lmco.com>
Subject: Re: Configuration Spaces
Date: Tue, 17 Sep 2002 09:48:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020917094800.A3340@atl.lmco.com>
References: <20020916110722.A28835@atl.lmco.com> <E17r1Ja-0001U3-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E17r1Ja-0001U3-00@usw-sf-list1.sourceforge.net>; from pbd@op.net on Mon, Sep 16, 2002 at 02:33:09PM -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks.

One other question.  This may be stupid, but here goes.

My knowledge of signals is that the period is the time it takes a signal to 
complete 1 cycle.  So what is the snd_pcm_hw_params_set_period used for?
Is the "period" a property of the signal, or an arbitrary property set by
the programmer for performance, fidelity, etc.

Thanks,
Chuck

On Mon, Sep 16, 2002 at 02:33:09PM -0400, Paul Davis wrote:
> >	1) Is the configuration space specific to each device, or each opened s
> >tream?
> 
> each open stream. obviously, its related to the underlying physical
> device, but you're semantically operation on one stream.
> 
> --p
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
