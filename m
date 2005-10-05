From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to get a list of sound devices
Date: Wed, 5 Oct 2005 11:17:51 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510051115240.29594-100000@studcom.urz.uni-halle.de>
References: <EA6A6906-679D-4BF9-9BA2-020026CF4AC9@popwire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <EA6A6906-679D-4BF9-9BA2-020026CF4AC9@popwire.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kenth Andersson <kenth@popwire.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kenth Andersson wrote:
> How do I from my C/C++ program get a list of all available sound
> devices on a ALSA machine,
> including the aliases and dsnoop/dmix devices that my .asoundrc file
> sets up? I've checked the API and didn't see any matching functions.

There are infinitely many possible device names; but try
snd_names_list().


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
