From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: alsa-devel-basic
Date: Mon, 14 Mar 2005 15:58:18 +0100
Message-ID: <20050314145818.GB23665@stud.ntnu.no>
References: <20050314124054.54237.qmail@web21205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314124054.54237.qmail@web21205.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: _R3D__5T4R_ <nomoref1ght@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 14, 2005 at 04:40:53AM -0800, _R3D__5T4R_ wrote:
> i'm a student of computer engineering and information,
> and i planning to make an net application using an
> audio, it's like VoIP, for my paperwork.
> 
> The problem is, even if i'm not new in programming
> but, for audio programming i don't have any idea.
> There is some basic that i don't know.

http://www.linuxjournal.com/article/6735
(Note that the variable dir in the listings should be initialized to 
zero for the examples to work properly.)

(This article used to contain a good figure, but it seems to be gone.)


> - what is rate, period time, period size, period, tick
> time  in *hw_params* means ? and what is used for ?

The sound card hardware buffer is divided into periodes, which are 
divided into frames, which are divided into samples (one per channel), 
which are divided into bytes.

Asbj.S.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
