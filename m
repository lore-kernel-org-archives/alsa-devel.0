From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: migrating from old to new alsa-api
Date: Sat, 24 Apr 2004 16:52:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <408A8D44.7030405@superbug.demon.co.uk>
References: <Pine.LNX.4.56.0404221556500.4307@spring>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56.0404221556500.4307@spring>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: barat@medien.uni-weimar.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

barat@medien.uni-weimar.de wrote:
> Hi,
> i need some clarifying about how the defines ALSA_PCM_OLD_HW_PARAMS_API 
> etc. behaves.
> for alsa-1.x its clear that if the app uses the new api i have to define 
> ALSA_PCM_NEW_HW_PARAMS_API, but what is for the case if i have an app with 
> the new api and the user uses only alsa9? is alsa1.x then backwards 
> compatible?
> 
> regards
> 
> Zsolt Barat
> 


ALSA_PCM_NEW_HW_PARAMS_API etc. is for use with alsa0.9.x
That define is assumed to be the default for alsa1.x.x

ALSA_PCM_OLD_HW_PARAMS_API is for use with alsa1.x.x to make it behave 
like "alsa0.9.x without the ALSA_PCM_NEW_HW_PARAMS_API".

Summary: -
To make your code work with bother alsa 0.9.x and 1.x.x, use 
ALSA_PCM_NEW_HW_PARAMS_API etc. and then write your code to the 1.x.x api.



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
