From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: how does alsa keep passing data into driver?
Date: Mon, 17 Oct 2005 08:37:09 +1300
Message-ID: <200510170837.12809.linux@blennerhassett.gen.nz>
References: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com> <bf04f99c0510160700y490bc9b6q8db1bd77957de4c2@mail.gmail.com> <43527114.2040601@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43527114.2040601@superbug.co.uk>
Content-Disposition: inline
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

On Mon, 17 Oct 2005 04:26, James Courtier-Dutton wrote:
> If your sound card cannot generate interrupts for each samples period,
> you basically cannot use it with Linux.

Not so.
You can use a timer to poll the card instead of an interrupt. 
See the "dummy" driver

--
Eliot


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
