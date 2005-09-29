From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Big-endian to little-endian conversion
Date: Thu, 29 Sep 2005 09:26:40 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509290924260.4137-100000@studcom.urz.uni-halle.de>
References: <BAY105-F230240E564304F590D37529F8D0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BAY105-F230240E564304F590D37529F8D0@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Brewer <jbrew8@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

John Brewer wrote:
> I assume that the plughw interface automatically converts the
> sound clip to the byte order required by the Quattro's playback
> device.

Yes.

> My question is, how I can I convert the data from big endian to little
> endian within my application?

With 16-bit values, you can use swab(), but it would be easier to tell
ALSA what sample format you want.  (Your program needs sample format
conversions anyway if it runs into a sound card that supports only ten
channels of 32-bit samples.)


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
