From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Mon, 31 Mar 2003 15:03:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030331150304.pochini@shiny.it>
References: <Pine.LNX.4.44.0303311307170.1602-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303311307170.1602-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>alsa-devel <alsa-devel@lists.sourceforge.net>, Paul Davis <paul@linuxaudiosystems.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


On 31-Mar-2003 Jaroslav Kysela wrote:
>> the case 2 is, IMO, the most straightforward way.  the info field will
>> have number of rows and columns, in addition to min, max and step
>> values.  the change in the alsa core wouldn't be too much.
> 
> I think that we simply touch the barrier given by 'struct
> sndrv_ctl_elem_id'. The identification which differentiate identical
> controls is only the 'index' value. If we don't use 'struct
> sndrv_ctl_elem_id' as the identification unit for read/writing of data,
> then we end with trouble with notification and other representation
> (single data unit locking, inactive flag etc). Imagine three or four
> dimensional data types. [...]

.count is an uint32. Ok, suppose we do not change it. Then the low
level driver has to tell user space apps that the index number
addresses elements in a W*H matrix, so the apps will locate the
cell at (x,y) by a simple index=x+W*y.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
