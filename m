From: Vincent Petry <PVince81@yahoo.fr>
Subject: Suggestion: Jack nodes detection
Date: Sun, 23 Nov 2008 09:30:40 +0800
Message-ID: <4928B240.9030905@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n64.bullet.mail.sp1.yahoo.com (n64.bullet.mail.sp1.yahoo.com
	[98.136.44.189]) by alsa0.perex.cz (Postfix) with SMTP id 1C54124381
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2008 02:30:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have noticed that from one model to another in ALC888 (maybe others as
well), the nodes for Int speakers, HP out, are not always the same.
But in the current driver model in patch_realtek.c we always hard-code
the node numbers, for example 0x14 for int speakers, 0x15 for hp out, etc.

It would be good to have it this way:
1. Add a spec attribute that contains the output nids in a given order
or a map, like this for my laptop:
alc888_acer_aspire_jack_nids =
{
{0x14, NID_INT_SPEAKER},
{0x15, NID_HP_OUT},
{0x18, NID_MIC_IN},
{0x1a, NID_LINE_IN},
{}
};

For another laptop, that has built-in subwoofer:
alc888_fujitsu_xa2530_jack_nids =
{
{
{0x14, NID_INT_SPEAKER},
{0x15, NID_INT_SPEAKER}, // subwoofer, also considered as int speaker
for the jack sense muting
{0x17, NID_LINE_OUT}, // this is also side
{0x18, NID_MIC_IN},
{0x1a, NID_LINE_IN},
{}
};


This way we could then use a function to access the NID number of each
one of them, for example get_jack_nid(..., NID_INT_SPEAKER).

2. Once this is implemented, we could add a detection routine that would
build the above map automatically, based on the spec info returned by
the codec.

3. Then I think we should add some special "detection" model that has no
hard-coded values that anyone could use by default, if no suitable model
def exists.

How about this idea? Is someone already working on it?

Thanks,

Vincent Petry
