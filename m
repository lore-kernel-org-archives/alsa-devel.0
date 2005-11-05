From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Question: setting up the hardware for alsa
Date: Sun, 6 Nov 2005 01:34:43 +0200
Message-ID: <20051105233443.GA10745@tecr>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com> <436B88BE.1090106@superbug.co.uk> <b15982770511040933t2ee5ec9dke8b898929cb287e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b15982770511040933t2ee5ec9dke8b898929cb287e1@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 11:33 Fri 04 Nov     , David Smoot wrote:
> 
> I can compile and run the first listing, it just prints out some variables
> set up by the soundalib. But the second listing that actually calls
> "snd_pcm_open"
> fails because it cannot open the default device.

You probably need to copy (create) some minimalistic configuration set
(such as in alsa-lib/src/conf ) in order to use "default" or "hw" device
names.

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
