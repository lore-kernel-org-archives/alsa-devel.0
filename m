From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH v5 1/2] ASoC: cs35l36: Add support for
 Cirrus CS35L36 Amplifier
Date: Sat, 22 Dec 2018 18:40:30 +0000
Message-ID: <63D76841-71C0-4207-89D3-25B5DF9998EF@cirrus.com>
References: <1545422004-4272-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E82C26798A
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 19:40:41 +0100 (CET)
In-Reply-To: <1545422004-4272-1-git-send-email-james.schulman@cirrus.com>
Content-Language: en-US
Content-ID: <256FB3D8ED95234DAD581D9498A0521A@namprd02.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Schulman, James" <James.Schulman@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 12/21/18, 1:53 PM, "James Schulman" <James.Schulman@cirrus.com> wrote:

    Add driver support for Cirrus Logic CS35L36 boosted
    speaker amplifier
    
    Signed-off-by: James Schulman <james.schulman@cirrus.com>
    ---
     include/sound/cs35l36.h    |   44 +
     sound/soc/codecs/Kconfig   |    5 +
     sound/soc/codecs/Makefile  |    2 +
     sound/soc/codecs/cs35l36.c | 1959 ++++++++++++++++++++++++++++++++++++++++++++
     sound/soc/codecs/cs35l36.h |  446 ++++++++++
     5 files changed, 2456 insertions(+)
     create mode 100644 include/sound/cs35l36.h
     create mode 100644 sound/soc/codecs/cs35l36.c
     create mode 100644 sound/soc/codecs/cs35l36.h
    
Acked-by: Brian Austin <brian.austin@cirrus.com>
