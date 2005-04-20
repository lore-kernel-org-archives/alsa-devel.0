From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Wed, 20 Apr 2005 17:33:49 +0800
Message-ID: <426621FD.2060209@netvigator.com>
References: <424A5D7D.2070400@netvigator.com>	<Pine.HPX.4.33n.0503301007400.20197-100000@studcom.urz.uni-halle.de>	<425E8CC5.3030601@netvigator.com>	<s5hy8bkchnd.wl@alsa2.suse.de>	<4264C3A5.50105@netvigator.com> <s5h64yjcdg7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64yjcdg7.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If I am using 16 SRC (hw:0,0) to play 16 voices instead of 64 voices WT 
engine, Is it possible to create a snd_pcm_substream_t for each voice in 
snd-au8830-synth and calling snd_vortex_pcm_open(), 
snd_vortex_pcm_hw_params(), snd_vortex_pcm_prepare(), 
snd_vortex_pcm_hw_free(), snd_vortex_pcm_close() in snd-au8830 ?


Takashi Iwai wrote:
> Raymond wrote:
> 
>>4) Can those snd_vortex_synth_alloc(), snd_vortex_synth_free(),
>>snd_vortex_synth_bzero() replaced by kmalloc(), kfree(), ... instead of
>>implementing a Memory blocks Management system with those fuctions in
>>util_mem.c ?
> 
> 
> The functions in util_mem.c are used to allocate/free blocks in a
> (virtually) linear address space dynamically.  These functions
> themselves are no replacement for kmalloc/kfree at all.
> 

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06924.html

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11687.html

Do we need to align the samples at 4K boundary ?

If yes, how do we implement offset_ptr(,,) and vortex_memblk_t ?

#define PAGE SIZE 4096

#define get_aligned_page(offset)	((offset) >> 12)
#define aligned_page_offset(page)	((page) << 12)

#define snd_vortex_synth_alloc(vortex,size)
snd_util_mem_alloc(vortex->memhdr, size)

#define snd_vortex_synth_free(vortex,blk)
snd_util_mem_free(vortex->memhdr,blk)

int snd_vortex_synth_bzero(vortex_t *vortex, snd_util_memblk_t *blk, int
offset, int size)
{
	int page, nextofs, end_offset, temp, temp1;
	void *ptr;
	vortex_memblk_t *p = (vortex_memblk_t *)blk;

	offset += blk->offset & (PAGE_SIZE - 1);
	end_offset = offset + size;
	page = get_aligned_page(offset);
	do {
		nextofs = aligned_page_offset(page + 1);
		temp = nextofs - offset;
		temp1 = end_offset - offset;
		if (temp1 < temp)
			temp = temp1;
		ptr = offset_ptr(vortex, page + p->first_page, offset);
		if (ptr)
			memset(ptr, 0, temp);
		offset = nextofs;
		page++;
	} while (offset < end_offset);
	return 0;
}

/*
  * copy_from_user(blk + offset, data, size)
  */
int snd_vortex_synth_copy_from_user(vortex_t *vortex, snd_util_memblk_t
*blk, int offset, const char __user *data, int size)
{
	int page, nextofs, end_offset, temp, temp1;

	offset += blk->offset;
	end_offset = offset + size;
	page = get_aligned_page(offset) + 1;
	do {
		nextofs = aligned_page_offset(page);
		temp = nextofs - offset;
		temp1 = end_offset - offset;
		if (temp1 < temp)
			temp = temp1;
		if (copy_from_user(offset_ptr(vortex, offset), data, temp))
			return -EFAULT;
		offset = nextofs;
		data += temp;
		page++;
	} while (offset < end_offset);
	return 0;
}













-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
