From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What and where is the function sa1100_dma_set_callback()??
Date: Tue, 11 Oct 2005 09:34:14 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510110908510.4097-100000@studcom.urz.uni-halle.de>
References: <715d90900510102300w2956bcedj8278b6ca17c46d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <715d90900510102300w2956bcedj8278b6ca17c46d3@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: boku <boku0712@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

boku wrote:
> I checked sa1100_request_dma() has 5 parameters, however, in #ifdef
> HH_VERSION, the called sa1100_request_dma() has only 3 parameters,

It seems that part of the kernel changed, and HH_VERSION is used to
detect this.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
