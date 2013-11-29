From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 12:48:02 +0530
Message-ID: <20131129071802.GD8834@intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <529841D9.7060301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B98572602F3
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 09:15:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <529841D9.7060301@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 29, 2013 at 09:27:21AM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 11/29/2013 06:29 AM, Vinod Koul wrote:
> >@@ -891,6 +892,11 @@ struct snd_ctl_elem_value {
> >  			unsigned char data[512];
> >  			unsigned char *data_ptr;	/* obsoleted */
> >  		} bytes;
> >+		struct {
> >+			unsigned long size;	/* size of buffer */
> >+			__u64 data;	i	/* user data pointer */
> >
> Typo here? (__u64 data;    i)
yup :( I aligned the comment in patch and looks like this got added. Thanks for
pointing...

--
~Vinod
