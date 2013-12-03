From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: compressed audio support (maruthi srinivas)
Date: Tue, 3 Dec 2013 10:28:34 +0530
Message-ID: <20131203045834.GM8834@intel.com>
References: <CAK7N6vrkSZALp2z5wpve1Cw6GWzWX=u060yEq8iukK1Oeqe1-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A23EB2650E4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 06:56:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAK7N6vrkSZALp2z5wpve1Cw6GWzWX=u060yEq8iukK1Oeqe1-g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish singh <anish198519851985@gmail.com>
Cc: maruthi.srinivas.b@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 02, 2013 at 03:24:51PM -0800, anish singh wrote:
> Both are compress framework driver files.
> compress_offload.c file is the one which interacts with userspace
> by using ioctl's, registers the compressed device with alsa
> framework(/dev/compress* gets created because of that),  calls
> the corresponding functions such as trigger, pointer update, copy
> and others when userspace pauses, plays and stops the playback
> or recording.
> 
> soc_compress.c file is the file which interacts with compress_offload.c
> file to create a 'dev' node for compress driver.Basically when you
> register your compress driver with compress framework,alsa core
> will come to know that your dai support compress operations and
> it will create the dev node by using soc_compress.c file.The functions
> in this file gets called by compress_offload.c functions and who
> inturn gets called by the userspace.
> 
> userspace->compress_offload.c->soc_compress.c->your_compress_driver.
userspace->compress_offload.c->your_compress_driver.

this will work too, as i said you are not bound to asoc but to framework
like PCM. We can have PCM alsa driver like PCI or something else or ASoC

--
~Vinod
