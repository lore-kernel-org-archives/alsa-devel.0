From: Daniel Danzberger <daniel@dd-wrt.com>
Subject: out of sync capture samples with MMAP on MIPS
Date: Sun, 27 May 2018 13:17:58 +0200
Message-ID: <9e34bcc3-cc8f-d651-6fc1-b81583e5c5b4@dd-wrt.com>
References: <e89758e0-b3db-c17c-71f5-e7acfbe76845@dd-wrt.com>
 <s5hsh6gnczj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.newmedia-net.de (webmail.newmedia-net.de [185.84.6.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F4E7267172
 for <alsa-devel@alsa-project.org>; Sun, 27 May 2018 13:18:02 +0200 (CEST)
In-Reply-To: <s5hsh6gnczj.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/25/2018 02:20 PM, Takashi Iwai wrote:> It's likely because of the cache
coherency issue on ARM.
> Currently USB-audio driver uses the buffer via vmalloc() for the
> intermediate buffer, and this may go out of sync on non-coherent arch
> like ARM.
> 
> Does the patch below help?  Not sure whether it works on ARM at all,
> as I've tested only on x86.

Your patch works. I cannot reproduce the issue anymore. Thanks.
