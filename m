From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: snd_pcm_lib_preallocate_pages_for_all
Date: Mon, 5 Jul 2004 10:00:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040705100038.B17721@flint.arm.linux.org.uk>
References: <A6991F0FA073F34C94E97976CAC0323116F8CA@server2.nordicid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <A6991F0FA073F34C94E97976CAC0323116F8CA@server2.nordicid.com>; from bo.henriksen@nordicid.com on Mon, Jul 05, 2004 at 11:56:25AM +0300
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bo Henriksen <bo.henriksen@nordicid.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 05, 2004 at 11:56:25AM +0300, Bo Henriksen wrote:
> It now crashes again. I have tried to preallocate the buffer using
> dma_alloc_coherent and free it with dma_free_coherent. This succeeds and
> I am using this in other drivers as well. I guess I am missing something
> else?

Yes, ALSA assumes that memory returned from dma_alloc_coherent is
kernel direct mapped memory.  ALSA is wrong in that assumption.
Hopefully ALSA people can help you further.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
