From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: How to get set/fixed sample rate of ALSA device?
Date: Mon, 08 Oct 2007 00:27:08 +0200
Message-ID: <47095D3C.5030901@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>	<4708F918.3060207@keyaccess.nl>
	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>
	<470958A9.7040607@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <470958A9.7040607@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Peteris Krisjanis <pecisk@gmail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/08/2007 12:07 AM, Rene Herman wrote:

> On 10/07/2007 07:04 PM, Peteris Krisjanis wrote:

>> So you suggest to open device via any means and then read that file? I 
>> did this and it works. I guess I can even try to implement it in app
>> and check for sample rate everytime before I play.

Oh, I only notice this now by the way. If you are actually going to play, I 
believe you should just try and set the params you want and see if it works 
(or test them first, through things like snd_pcm_hw_params_test_rate().

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
