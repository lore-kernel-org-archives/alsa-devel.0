From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: .dimen ?
Date: Tue, 20 May 2003 11:58:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030520115838.pochini@shiny.it>
References: <s5hr86uc872.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr86uc872.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 20-May-2003 Takashi Iwai wrote:
>> In struct sndrv_ctl_elem_info what is the union .dimen for ?
>
> it was introduced to describe the size of matrix controls.
> basically the control API accepts the linear index, so user (or
> alsa-lib) needs to map the multi-dimensional array to the linear
> index.  the dimen field specifies the number of elements in each
> dimension.  (up to 4 dimensions are supposed.)
> so far, no driver supports this feature yet, though...

Fine, it's very useful. I'll try it ASAP.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
