From: Lee Revell <rlrevell@joe-job.com>
Subject: RE: Sound Card Driver
Date: Mon, 20 Dec 2004 02:29:04 -0500
Message-ID: <1103527744.1252.75.camel@krustophenia.net>
References: <1103525753.5179.24.camel@oaks.mumbai.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1103525753.5179.24.camel@oaks.mumbai.redhat.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kshriyan@redhat.com
Cc: cltien@cmedia.com.tw, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-12-20 at 12:25 +0530, Kaushal Shriyan wrote:
> Hi Tien
> 
> I have used the following steps
> ./configure --with-oss=yes --with-sequencer=yes --with-cards=azx
> make
> make install
> 
> The drivers get compiled successfully, but when I run the soundcard
> detection gui application, I get NO SOUND CARD Detected.

Support for this card is very new.  It's possible that whatever
application you are using is not aware of this card yet.

Which soundcard detection app are you running?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
