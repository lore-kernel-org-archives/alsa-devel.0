From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: alsa & snd-hdsp
Date: 23 May 2003 19:13:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053735237.27571.3.camel@eviltwin>
References: <1053726881.414.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1053726881.414.4.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

David,

	I asked about this early on and I believe that the answer is that you
control the input gain externally.  Some kind of mixer or pre-amp is
needed.

Jan

On Fri, 2003-05-23 at 16:54, David E. Storey wrote:
> ok...
> 
> I'd like to know if I fumez le crack! Is there any way to adjust the
> gain on any HDSP inputs via alsa? I know there exist simple controls,
> which control the output volume and the mixer controls which handily set
> the volume between any input and output.... so what about input? The
> mixer in winbloze seems not to adjust input level either? Is this a
> firmware issue? Do I need to get an 8-channel pre-amp in order to adjust
> the signals into my multiface?
> 
> d!
> -- 
> Don't ever take a fence down until you know the reason it was put up.
>         - G.K. Chesterton
> 
> 




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
