From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] snd_usb_caiaq: use likely()/unlikely()
Date: Sat, 12 Apr 2008 23:01:19 +0200
Message-ID: <20080412210119.GB13041@buzzloop.caiaq.de>
References: <20080412201331.GA13041@buzzloop.caiaq.de>
	<20080412202127.GB8849@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D5892448D
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 23:01:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080412202127.GB8849@cs181133002.pp.htv.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Bunk <bunk@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Apr 12, 2008 at 11:21:27PM +0300, Adrian Bunk wrote:
> Does it bring any measurable advantage?
> 
> Otherwise it's usually better to let the compiler decide how to optimize 
> the code.

I didn't really measure, but how should the compiler know how likely a
certain condition in hardware state is? I thought, in such cases it's
generally a good idea to give the compiler some hints.

Daniel
