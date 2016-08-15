From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v5 0/2] amidi delay option
Date: Tue, 16 Aug 2016 04:54:49 +0900
Message-ID: <57B21E09.2030900@sakamocchi.jp>
References: <20160815163734.17658-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050609090402070800020903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 199D8266644
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 21:54:58 +0200 (CEST)
In-Reply-To: <20160815163734.17658-1-eu@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Felipe F. Tonello" <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050609090402070800020903
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi,

On Aug 16 2016 01:37, Felipe F. Tonello wrote:
> Small improvement to amidi, adding useful functionality.
> 
> changes from v4:
>  * simplified code
> 
> changes from v3:
>  * fixed a bug if memchr() returns NULL
> 
> changes from v2:
>  * only check of end of sysex (0xf7)
>  * use memchr() instead of direct loop approach
>  * fixed commit message
> 
> changes from v1:
>  * remove delay in between any MIDI message, only SysEx
>  * added patch to use getopt_long() arguments
> 
> Felipe F. Tonello (2):
>   amidi: add delay option
>   amidi: use GNU getopt_long() proper argument names
> 
>  amidi/amidi.1 | 14 ++++++++++++++
>  amidi/amidi.c | 61 +++++++++++++++++++++++++++++++++++++++++++----------------
>  2 files changed, 59 insertions(+), 16 deletions(-)

Please notice the other developers' work. Clemens already posted his
patchset with similar improvements.

http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111737.html

And I reviewed and tested it.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111745.html

It's not merged yet, because subsystem maintainer has a summer vacation.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111741.html

It's better for you to wait for merging or work based on Clemens'
patchset, I think.


Regards

Takashi Sakamoto

--------------050609090402070800020903
Content-Type: application/pgp-keys;
 name="0xD66FD341.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0xD66FD341.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
gloyG7N0i04Q0bOrMbJoxqlzmoS55olmleRTy5RnabCRozge9pPew56ewdty7X5G
9flckZN9T+/SOaQh8H60/elCS4eJedH5uXFdqdU8KillzbLosjyiqF29vZ6nKV3Q
0V130i9eYVK51ksTqnYJegr3kzxGTqGbjPRRKj2Md8RE4WzLHRWmsmRi3twvHhr0
kPPybqMjL9PwmJByQM3kkOHmfNv9N5C6qMr5p1KCJnkQROrb5z6VYEdoyqHpnUga
FdOtn3jSt1TQRyPWoV76Mi7iKx2kjxIrOA+eEz5aFy7ZRGL1fAuSKLLeRM9wWCY6
RJ2vDzvJFmlZHqdTtbcUe8851KCsnbRdjsatdvx+9aJNGZ2CdA/igJIFqd8qCKRv
tu5z5HvjiIKCfzS8VjYcK0zvykqwZ9trfnzvI0T2SsyhzBr7gIIRSaebS7EptO6n
njnwrlS0Po/sF5++/iRcDEXvRY0nqSPDn4kbM5veoEIbQxS7S4WJAhwEEAEKAAYF
AlajMJsACgkQbGrNZBezrLHE6w//RcYt3dkkuXfZME32G3XdobUDo4kr4bGgORT9
BjZLpIxGtMljGMYiS7ezWpR2NVPkmeGCUlWBg9PUkFx6VyJwVGGqvvZ4m8bgNp0v
hMQ6MijbTB8D0Zv3FZ8EXkvvc5qI1lHA7bMF/FyGRC1RodU4f7oNTGK48dXTGc/t
ZSTVHn9AjgUA2FOcis0w4tG45lofC+4oqGk4FJ7UTHltMcwwNDO6KxP577mpvYE4
ukl4kP0gF30X8NntlTWRU5D30EEpM+KtLwtK1rNdMID+7ZYAz2XujU6XdkeO5mAL
Y05SzmmgCcbG4YD8MYbOi0brrZmA7+eweEZI19POanOKvkbXsFK9imn53Z53lnS/
9swJ0jJtbW/ASONBvKEcbtvwaXWcgcRh6cAippD8R9kPI6pHcP3m5Ry7k77GKK8O
RJzvc3XWAwoX5t9ce2ITPri9N1Q8eSwha8t11Mlb7ln+f2qsJTBvbHPpSUvaIFWm
Yn0ta6iSvDn+HbdmK22ke6Oj3SFWbIL2geOpr4RNqrVcyMF+wzlkcf9uncdR2ZXf
SL2m9tK7J00WgsC7GvfkBcODlXc/bIU33V4N2o9a3rbgstGoHuV3RuycHvksYgE9
yoCJ4ZCcP547AFv6wh4p+l/tSBp8oWNHE9E7tNh6mAkGZBav0/y3qPrkkItcELfu
XQoglOS5Ag0EU6Z+ugEQAKwKJtLJMlOTrr/kTB+ZQNqXC5VltAkFlqW2lGH7PsxG
vLAfG/Iy5qUz2FXx47qtxY0lx4M/A5gQi5V8iJQT/Kz2Upxtz1AoXmzaSd0CcqrU
rScQ42D1pPDDtGZlh1XG14/5w9AUvBPBM7Wjfx0J+Vrq/lPUm4MWuRfiBYxqMH+l
Nd3hQVGtQWH6GOYEGcz9ImkEnGu3tAB7OHzW+clK4LCHmYTk0rGMB5M9pBNndmr9
iz2nmwe80lQPlMW5sgHrrCY9ECIO9mqZUIA/WEbbZCYw4UYVLwgXXkgVq9iFciQS
uA6wj0/6odCcFnmk4Gr5ga+YgTIfPrcTbMB1kp5icK3dQluUpQlF633BpuqPRWQz
Xuzkgt9Jve2dOhSwwFKJ1ZV8UNpWhB0YTVV6WtdHKMCJFEDbCIRh9hedb2vTJDTB
kEC5qHIjWpgAUhE2Z+yEzOePJGjcQss9roZBYfUhlubrtkH0qAGbgO0zrQOAXET2
ReXQTVWaTWvXQUTMv2V7fksRIp53EuGnMfShVO6EQKjVhPfWeyJBDBN0/5/wDNXK
fZtce9/hDmuso12s151QeJ8N+OjNAJ1e+DDNIrXCWyMH4ukHdK24BBMSuIJsjWrV
/aSpPWrEM+/J9Wz5vXVOmSX5JeAAn/I/jqgNllTbUoMbiOQGwXaNEwyggXRZgcZz
ABEBAAGJAh8EGAECAAkFAlOmfroCGwwACgkQtaWGx9Zv00FhHw/9FS1vmKbo/czW
9zgBYzk8yh0rzDYwF7BQqmgZiUQiyHiYcVbn2ICZmlH7D+TClNymFQ5Jz+z7D7Wz
y9QZUPh0hY6eYD35/ahueGklil0EAk5pE/tYp67nqeBW7inSWz85nWffxF/QDlES
YqMA4tT2/b++JJf+Rh518FSOEB/FizR25Ok0Y12gzzg+OLYpVBxhrbqGQ5eNB2kf
lVgDMkiEZyLR/DPO4oewn6aaMhD4qHLvFjbkG8TQeABe0BqW9JKHfKIw5MTRPUue
0nvVgPAjuFZ4sw4zz18dUzxH+mjC5ODg/zltHwpJoOCwPtTMZ4CyhnG7m81xgfWQ
q4lD4WM08nt80+WBGQURJik3iRMpk4h+oieXXCDx18T24BlCVo1dZ2ibwIX8eSB6
hey+WL+9vJdUkV1O/GhVPiyfUBockx/Px99hZAllHVaHvXMJoyRc7mFt6QqLhn33
IHiQaUARpWWG1AvT0P2Alb24o4Ww9AexokYpKzvsj0MJsq2A8wGY+kudrGAEaKFu
aDriPfv/7LeUjR7qMGa982utXsWPv1wlAo3XDldK/G+i6DURWQaAUCLEukoL8LvY
LPKA9lnCkfM4O3HVoPmkqlb3AbX6eQWw8egRiK97jeSXa9FUhMdj0AIV9NgSNQCp
y+EqALRWdSvPhX9lfFOn5TH2wFte1/g=
=fyMe
-----END PGP PUBLIC KEY BLOCK-----

--------------050609090402070800020903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050609090402070800020903--
