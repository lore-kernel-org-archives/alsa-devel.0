From: "John Brewer" <jbrew8@hotmail.com>
Subject: Re: Big-endian to little-endian conversion
Date: Thu, 29 Sep 2005 23:12:28 -0400
Message-ID: <BAY105-F56504D643D674ECA76CE39F8F0@phx.gbl>
References: <Pine.HPX.4.33n.0509290924260.4137-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0509290924260.4137-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks a lot for your help- I figured there would have to be a function to 
swap the byte order, but for some reason I couldn't find it.  I'll try it 
this weekend and see if I can solve my problem.

John


>From: Clemens Ladisch <clemens@ladisch.de>
>To: John Brewer <jbrew8@hotmail.com>
>CC: <alsa-devel@lists.sourceforge.net>
>Subject: Re: [Alsa-devel] Big-endian to little-endian conversion
>Date: Thu, 29 Sep 2005 09:26:40 +0200 (METDST)
>
>John Brewer wrote:
> > I assume that the plughw interface automatically converts the
> > sound clip to the byte order required by the Quattro's playback
> > device.
>
>Yes.
>
> > My question is, how I can I convert the data from big endian to little
> > endian within my application?
>
>With 16-bit values, you can use swab(), but it would be easier to tell
>ALSA what sample format you want.  (Your program needs sample format
>conversions anyway if it runs into a sound card that supports only ten
>channels of 32-bit samples.)
>
>
>HTH
>Clemens
>

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
