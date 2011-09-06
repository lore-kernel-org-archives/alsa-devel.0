From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: overrun in case of record
Date: Tue, 6 Sep 2011 11:01:38 -0700
Message-ID: <20110906180138.GC2924@opensource.wolfsonmicro.com>
References: <4E65E934.2070706@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7952103835
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 20:05:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E65E934.2070706@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2011 at 03:04:44PM +0530, Rajeev kumar wrote:

> I am using arecord for capturing data.
> #arecord -f dat > t
> overrun!!! (at least 32.949 ms long)
> 
> Overrun issue: The issue is only reproducible if we try to record
> for more than 40 sec.The strange part is that Instead of overrun
> condition generated,
> it will record complete data for 10sec.(This is verified with the
> number of bytes recorded).
> So could you please let me know whether this is an error condition
> or just a warning.

An overrun means that your driver is producing data faster than the
application is reading it and ran out of buffer space.  This may mean
that you're running at the wrong sample rate, or it may mean that your
system is just too slow to do recordings.

> pcm_read error: For this I have seen a bug is locked in the
> bugzila(*Bug 472469* <show_bug.cgi?id=472469> -arecord: input/output
> error ). and the status  is closed saying insufficient data.
> Could you please let me know what is the meaning of this bug? Is it
> like, data is not available in the buffer and pcm_read from the user
> space fails? But why this situation will
> arise?

You'll need to investigate the bug.
