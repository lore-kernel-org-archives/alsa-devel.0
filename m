From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH - UCM 2/2] ucm: add binary configure file
	parse
Date: Wed, 14 Jan 2015 11:29:54 +0000
Message-ID: <1421234994.11933.17.camel@loki>
References: <1421118039-8075-1-git-send-email-han.lu@intel.com>
 <1421118039-8075-2-git-send-email-han.lu@intel.com>
 <s5hbnm2ipxm.wl-tiwai@suse.de> <1421173578.6402.72.camel@loki>
 <s5hwq4q1muh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DE5A5261647
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 12:30:01 +0100 (CET)
In-Reply-To: <s5hwq4q1muh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: han.lu@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-01-13 at 20:50 +0100, Takashi Iwai wrote:
> At Tue, 13 Jan 2015 18:26:18 +0000,
> Liam Girdwood wrote:
> > 
> > On Tue, 2015-01-13 at 17:52 +0100, Takashi Iwai wrote:
> > > At Tue, 13 Jan 2015 11:00:39 +0800,
> > > han.lu@intel.com wrote:
> > > > 
> > > > From: "Lu, Han" <han.lu@intel.com>
> > > > 
> > > > with cset command, UCM set kcontrol parameters directly:
> > > >     cset "name='<KCONTROL_NAME>' 1,2<,3,...>"
> > > > This patch enables UCM to set kcontrol with parameters from
> > > > configure file:
> > > >     bcsetf "name='<KCONTROL_NAME>' <path/to/file>"
> > > > where "bcsetf" is a newly added keyword alongside of "cset", to
> > > > indicate binary cset with file; and <path/to/file> is the
> > > > configure file storing parameters in bytes array, up to 512 Bytes
> > > > (the maxim value that struct snd_ctl_elem_value can hold).
> > > 
> > > Why binary?  It's not portable.  You can't carry it to a different
> > > architecture.
> > > 
> > 
> > The intention here is that the binary data is not meant for the host but
> > for audio DSPs so it's just passed by UCM/ALSA as raw data.
> 
> In that case, we should limit to certain element data types.
> Otherwise people would abuse it for passing data even to integer or
> enum ctls.
> 
> And of course it'd be better to clarify the reason in the patch
> description :)
> 
> BTW, I'm still not so convinced by bcsetf...  Can't it be more verbose
> or readable?
> 

Yeah, we should probably make it more readable :)

Lu Han will probably have some naming suggestions shortly....

Liam
