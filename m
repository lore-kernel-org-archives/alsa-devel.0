From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Apr 30 (sound)
Date: Tue, 30 Apr 2013 11:42:08 -0700
Message-ID: <51801080.6050809@infradead.org>
References: <20130430165730.7779d7e5d8fdca911213cce7@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130430165730.7779d7e5d8fdca911213cce7@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, alsa <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/29/13 23:57, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any v3.11 destined work to your linux-next included
> branches until after v3.10-rc1 is released.
> 
> Changes since 20130429:
> 


when CONFIG_PROC_FS is not enabled:

sound/core/memalloc.c: In function 'snd_mem_exit':
sound/core/memalloc.c:525:20: error: 'SND_MEM_PROC_FILE' undeclared (first use in this function)


-- 
~Randy
